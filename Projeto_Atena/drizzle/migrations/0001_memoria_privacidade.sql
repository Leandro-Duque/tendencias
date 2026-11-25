alter table public.perfis add column if not exists semestre text;

create or replace function public.mascarar_texto(t text)
returns text language sql immutable set search_path = public as $$
  select regexp_replace(
         regexp_replace(
         regexp_replace(
         regexp_replace(coalesce(t,''),
           '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}', '[e-mail]', 'g'),
           '\d{3}\.?\d{3}\.?\d{3}-?\d{2}', '[cpf]', 'g'),
           '(\+?55\s?)?\(?\d{2}\)?\s?9?\d{4}[-\s]?\d{4}', '[telefone]', 'g'),
           '\d{5,}', '[documento]', 'g')
$$;

create table public.resumos_conversa (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null,
  conversa_id uuid references public.conversas(id) on delete set null,
  resumo text not null,
  criado_em timestamptz not null default now(),
  expira_em timestamptz not null default (now() + interval '90 days')
);
grant select, insert, delete on public.resumos_conversa to authenticated;
grant all on public.resumos_conversa to service_role;
alter table public.resumos_conversa enable row level security;
create policy "dono lê resumos" on public.resumos_conversa for select to authenticated using (user_id = auth.uid() and expira_em > now());
create policy "dono cria resumos" on public.resumos_conversa for insert to authenticated with check (user_id = auth.uid());
create policy "dono apaga resumos" on public.resumos_conversa for delete to authenticated using (user_id = auth.uid());

create or replace function public.mascarar_resumo() returns trigger language plpgsql set search_path = public as $$
begin new.resumo := public.mascarar_texto(new.resumo); new.expira_em := now() + interval '90 days'; return new; end $$;
create trigger trg_mascarar_resumo before insert or update on public.resumos_conversa for each row execute function public.mascarar_resumo();

create or replace function public.mascarar_log() returns trigger language plpgsql set search_path = public as $$
begin
  new.acao := public.mascarar_texto(new.acao);
  if new.detalhes is not null then new.detalhes := public.mascarar_texto(new.detalhes::text)::jsonb; end if;
  return new;
exception when others then new.detalhes := null; return new;
end $$;
create trigger trg_mascarar_log before insert on public.logs_acoes for each row execute function public.mascarar_log();

create table public.preferencias (
  user_id uuid primary key,
  memoria_longa_ativa boolean not null default false,
  canal_preferido text,
  lembretes_ativos boolean,
  nivel_linguagem text,
  atualizado_em timestamptz not null default now()
);
grant select, insert, update, delete on public.preferencias to authenticated;
grant all on public.preferencias to service_role;
alter table public.preferencias enable row level security;
create policy "dono preferencias" on public.preferencias for all to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());

create or replace function public.limpar_preferencias() returns trigger language plpgsql set search_path = public as $$
begin
  if not new.memoria_longa_ativa then
    new.canal_preferido := null; new.lembretes_ativos := null; new.nivel_linguagem := null;
  end if;
  new.atualizado_em := now();
  return new;
end $$;
create trigger trg_limpar_preferencias before insert or update on public.preferencias for each row execute function public.limpar_preferencias();

alter table public.protocolos add column if not exists restrito boolean not null default false;
alter table public.protocolos add column if not exists detalhes_restritos text;

create table public.equipe_setores (
  user_id uuid not null,
  setor text not null,
  primary key (user_id, setor)
);
grant select on public.equipe_setores to authenticated;
grant all on public.equipe_setores to service_role;
alter table public.equipe_setores enable row level security;
create policy "ver próprio setor" on public.equipe_setores for select to authenticated using (user_id = auth.uid());

create or replace function public.pertence_setor(_user_id uuid, _setor text)
returns boolean language sql stable security definer set search_path = public
as $$ select exists (select 1 from public.equipe_setores where user_id = _user_id and setor = _setor) $$;

drop policy if exists "equipe protocolos" on public.protocolos;
create policy "equipe protocolos" on public.protocolos for all to authenticated
  using (public.has_role(auth.uid(),'equipe') and (not restrito or public.pertence_setor(auth.uid(), setor)))
  with check (public.has_role(auth.uid(),'equipe'));

create extension if not exists pg_cron;
select cron.schedule('apagar-resumos-expirados', '0 3 * * *', $$ delete from public.resumos_conversa where expira_em < now(); $$);