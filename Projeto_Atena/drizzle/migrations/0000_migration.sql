create type public.app_role as enum ('estudante','equipe');

create table public.perfis (
  id uuid primary key references auth.users(id) on delete cascade,
  nome text not null default '',
  email text,
  matricula text not null default '',
  curso text not null default '',
  aceite_privacidade_em timestamptz,
  criado_em timestamptz not null default now()
);
grant select, insert, update, delete on public.perfis to authenticated;
grant all on public.perfis to service_role;
alter table public.perfis enable row level security;

create table public.user_roles (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade not null,
  role public.app_role not null,
  unique (user_id, role)
);
grant select on public.user_roles to authenticated;
grant all on public.user_roles to service_role;
alter table public.user_roles enable row level security;

create or replace function public.has_role(_user_id uuid, _role public.app_role)
returns boolean language sql stable security definer set search_path = public
as $$ select exists (select 1 from public.user_roles where user_id = _user_id and role = _role) $$;

create policy "ver próprios papéis" on public.user_roles for select to authenticated
  using (user_id = auth.uid() or public.has_role(auth.uid(),'equipe'));

create policy "ver próprio perfil" on public.perfis for select to authenticated
  using (id = auth.uid() or public.has_role(auth.uid(),'equipe'));
create policy "editar próprio perfil" on public.perfis for update to authenticated
  using (id = auth.uid()) with check (id = auth.uid());

create table public.documentos_oficiais (
  id uuid primary key default gen_random_uuid(),
  titulo text not null,
  tipo text not null,
  texto text not null,
  data_vigencia date,
  fonte text,
  criado_em timestamptz not null default now()
);
grant select on public.documentos_oficiais to authenticated;
grant insert, update, delete on public.documentos_oficiais to authenticated;
grant all on public.documentos_oficiais to service_role;
alter table public.documentos_oficiais enable row level security;
create policy "logados leem documentos" on public.documentos_oficiais for select to authenticated using (true);
create policy "equipe gerencia documentos" on public.documentos_oficiais for all to authenticated
  using (public.has_role(auth.uid(),'equipe')) with check (public.has_role(auth.uid(),'equipe'));

create table public.conversas (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null,
  titulo text not null default 'Nova conversa',
  criado_em timestamptz not null default now()
);
create table public.mensagens (
  id uuid primary key default gen_random_uuid(),
  conversa_id uuid not null references public.conversas(id) on delete cascade,
  user_id uuid not null,
  papel text not null check (papel in ('user','assistant')),
  conteudo text not null,
  criado_em timestamptz not null default now()
);
create table public.protocolos (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null,
  tipo text not null,
  status text not null default 'aberto',
  setor text not null,
  resumo text not null,
  criado_em timestamptz not null default now()
);
create table public.feedbacks (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null,
  mensagem_id uuid references public.mensagens(id) on delete set null,
  nota int,
  comentario text,
  criado_em timestamptz not null default now()
);
create table public.logs_acoes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  acao text not null,
  detalhes jsonb,
  criado_em timestamptz not null default now()
);

grant select, insert, update, delete on public.conversas, public.mensagens, public.protocolos, public.feedbacks to authenticated;
grant select, insert on public.logs_acoes to authenticated;
grant all on public.conversas, public.mensagens, public.protocolos, public.feedbacks, public.logs_acoes to service_role;
alter table public.conversas enable row level security;
alter table public.mensagens enable row level security;
alter table public.protocolos enable row level security;
alter table public.feedbacks enable row level security;
alter table public.logs_acoes enable row level security;

create policy "dono conversas" on public.conversas for all to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy "equipe lê conversas" on public.conversas for select to authenticated using (public.has_role(auth.uid(),'equipe'));
create policy "dono mensagens" on public.mensagens for all to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy "equipe lê mensagens" on public.mensagens for select to authenticated using (public.has_role(auth.uid(),'equipe'));
create policy "dono protocolos lê" on public.protocolos for select to authenticated using (user_id = auth.uid());
create policy "dono protocolos cria" on public.protocolos for insert to authenticated with check (user_id = auth.uid());
create policy "equipe protocolos" on public.protocolos for all to authenticated using (public.has_role(auth.uid(),'equipe')) with check (public.has_role(auth.uid(),'equipe'));
create policy "dono feedbacks" on public.feedbacks for all to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy "equipe lê feedbacks" on public.feedbacks for select to authenticated using (public.has_role(auth.uid(),'equipe'));
create policy "registrar próprio log" on public.logs_acoes for insert to authenticated with check (user_id = auth.uid());
create policy "ler próprio log" on public.logs_acoes for select to authenticated using (user_id = auth.uid() or public.has_role(auth.uid(),'equipe'));

create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = public
as $$
begin
  insert into public.perfis (id, nome, email, matricula, curso)
  values (new.id, coalesce(new.raw_user_meta_data->>'nome', split_part(new.email,'@',1)), new.email,
          '2026' || lpad((floor(random()*100000))::int::text, 5, '0'),
          (array['Pedagogia','Engenharia Civil','Enfermagem','Ciência da Computação','Letras'])[1 + floor(random()*5)::int]);
  insert into public.user_roles (user_id, role) values (new.id, 'estudante');
  return new;
end; $$;
create trigger on_auth_user_created after insert on auth.users for each row execute function public.handle_new_user();

insert into public.documentos_oficiais (titulo, tipo, texto, data_vigencia, fonte) values
('Calendário Acadêmico 2026/2', 'calendario', 'DOCUMENTO FICTÍCIO. Início das aulas: 03/08/2026. Rematrícula: 20/07 a 31/07/2026. Ajuste de matrícula: 03/08 a 10/08/2026. Prazo final para trancamento: 15/09/2026. Semana acadêmica: 19/10 a 23/10/2026. Fim das aulas: 11/12/2026. Exames finais: 14/12 a 18/12/2026. Lançamento de notas até 22/12/2026.', '2026-08-03', 'Pró-Reitoria de Graduação – Universidade Exemplo'),
('Regras de Trancamento de Matrícula', 'regulamento', 'DOCUMENTO FICTÍCIO. O trancamento pode ser total ou parcial. O pedido é feito pelo Portal do Estudante até a data limite do calendário acadêmico. Limite de 4 semestres de trancamento total durante o curso. Estudantes ingressantes não podem trancar no primeiro semestre, salvo motivo de saúde comprovado. Bolsistas devem comunicar a Assistência Estudantil, pois o trancamento pode suspender o benefício. A análise é feita pela Secretaria Acadêmica em até 10 dias úteis.', '2026-01-01', 'Resolução CONSUNI 12/2025 – Universidade Exemplo'),
('Regras de Aproveitamento de Disciplinas', 'regulamento', 'DOCUMENTO FICTÍCIO. O aproveitamento pode ser solicitado para disciplinas cursadas em instituições reconhecidas nos últimos 10 anos. Exige compatibilidade mínima de 75% da carga horária e do conteúdo. Documentos: histórico escolar oficial e ementas assinadas. Pedido via Portal do Estudante nas 2 primeiras semanas do semestre. A coordenação do curso analisa em até 30 dias.', '2026-01-01', 'Resolução CEPE 08/2025 – Universidade Exemplo'),
('Edital de Auxílio Alimentação 03/2026', 'edital', 'DOCUMENTO FICTÍCIO. Valor: R$ 300,00 mensais por 5 meses. Inscrições: 01/08 a 21/08/2026, exclusivamente pelo Portal do Estudante. Requisitos: estar matriculado em curso de graduação presencial; renda familiar per capita de até 1,5 salário mínimo; não possuir outro auxílio alimentação. Documentos: comprovantes de renda de todos os membros da família, comprovante de residência e CadÚnico (se houver). Resultado preliminar: 04/09/2026. Recursos: 05/09 a 08/09/2026. Resultado final: 15/09/2026.', '2026-08-01', 'Pró-Reitoria de Assuntos Estudantis – Universidade Exemplo'),
('Edital de Bolsa de Permanência 04/2026', 'edital', 'DOCUMENTO FICTÍCIO. Valor: R$ 700,00 mensais por 10 meses. Vagas: 150. Inscrições: 10/08 a 31/08/2026 pelo Portal do Estudante. Requisitos: graduação presencial; renda familiar per capita de até 1 salário mínimo; frequência mínima de 75%; não acumular com outra bolsa de mesma natureza. Prioridade para estudantes de escola pública, indígenas, quilombolas e pessoas com deficiência. Exige entrevista social. Resultado final previsto: 30/09/2026.', '2026-08-10', 'Pró-Reitoria de Assuntos Estudantis – Universidade Exemplo'),
('Guia dos Serviços de Apoio ao Estudante', 'guia', 'DOCUMENTO FICTÍCIO. Assistência Estudantil (PRAE): auxílios, bolsas e moradia; atendimento de segunda a sexta, 8h às 17h, Bloco A, sala 101, e-mail prae@exemplo.edu.br. Núcleo de Acessibilidade: apoio a estudantes com deficiência, intérprete de Libras, materiais adaptados; Bloco B, sala 12, acessibilidade@exemplo.edu.br. Acolhimento Psicológico: escuta e orientação gratuitas, agendamento pelo e-mail acolhe@exemplo.edu.br. Em situação de crise ou risco à vida, ligue 188 (CVV, 24h) ou 192 (SAMU).', '2026-01-01', 'Pró-Reitoria de Assuntos Estudantis – Universidade Exemplo');