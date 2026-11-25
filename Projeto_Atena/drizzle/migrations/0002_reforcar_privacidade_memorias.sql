create table public.protocolos_restritos (
 protocolo_id uuid primary key references public.protocolos(id) on delete cascade,
 setor text not null,
 conteudo text not null
);
grant select on public.protocolos_restritos to authenticated;
grant all on public.protocolos_restritos to service_role;
alter table public.protocolos_restritos enable row level security;
create policy setor_competente on public.protocolos_restritos for select to authenticated using (public.has_role(auth.uid(),'equipe') and public.pertence_setor(auth.uid(),setor));
insert into public.protocolos_restritos(protocolo_id,setor,conteudo) select id,setor,public.mascarar_texto(detalhes_restritos) from public.protocolos where detalhes_restritos is not null on conflict do nothing;
comment on column public.protocolos.detalhes_restritos is 'DEPRECATED: replaced by public.protocolos_restritos; not readable via Data API';
revoke select on public.protocolos from authenticated;
grant select(id,user_id,tipo,status,setor,resumo,criado_em,restrito) on public.protocolos to authenticated;
create or replace function public.restringir_protocolo() returns trigger language plpgsql security definer set search_path = public as $$
begin
 if new.detalhes_restritos is not null then
  insert into public.protocolos_restritos(protocolo_id,setor,conteudo) values(new.id,new.setor,public.mascarar_texto(new.detalhes_restritos)) on conflict(protocolo_id) do update set setor=excluded.setor,conteudo=excluded.conteudo;
  update public.protocolos set detalhes_restritos=null, restrito=true, resumo='Atendimento com informações restritas ao setor.' where id=new.id;
 end if;
 return new;
end $$;
create trigger separar_detalhes after insert or update of detalhes_restritos on public.protocolos for each row execute function public.restringir_protocolo();

create or replace function public.validar_preferencias() returns trigger language plpgsql set search_path = public as $$
begin
 if new.canal_preferido is not null and new.canal_preferido not in ('chat','e-mail','presencial') then raise exception 'Canal inválido'; end if;
 if new.nivel_linguagem is not null and new.nivel_linguagem not in ('simples','detalhada') then raise exception 'Linguagem inválida'; end if;
 return new;
end $$;
create trigger validar_preferencias before insert or update on public.preferencias for each row execute function public.validar_preferencias();

create or replace function public.mascarar_log() returns trigger language plpgsql set search_path = public as $$
begin
 new.acao := case when new.acao in ('aceite_privacidade','download_dados','pedido_exclusao','pedido_exclusao_conta','memoria_longa_ligada','memoria_longa_desligada','resumo_apagado','todos_resumos_apagados','preferencias_atualizadas','sessao_encerrada') then public.mascarar_texto(new.acao) else 'acao_registrada' end;
 new.detalhes := null;
 return new;
end $$;

revoke insert on public.resumos_conversa from authenticated;
create or replace function public.salvar_resumo_seguro(_conversa_id uuid,_temas text[]) returns void language plpgsql security definer set search_path = public as $$
declare texto text; protocolo text;
begin
 if auth.uid() is null or not exists(select 1 from public.conversas where id=_conversa_id and user_id=auth.uid()) then raise exception 'Conversa não autorizada'; end if;
 if cardinality(_temas) < 1 or cardinality(_temas) > 6 or exists(select 1 from unnest(_temas) t where t not in ('calendário acadêmico','trancamento','aproveitamento de disciplinas','auxílios e bolsas','serviços de apoio','orientação acadêmica')) then raise exception 'Tema não permitido'; end if;
 select case when exists(select 1 from public.protocolos where user_id=auth.uid() and status='aberto') then 'atendimento aberto' else 'nenhum atendimento aberto' end into protocolo;
 texto := public.mascarar_texto('Tema: '||array_to_string(_temas,', ')||E'\nProtocolo: '||protocolo||E'\nPendências: '||case when protocolo='atendimento aberto' then 'aguardar atendimento da equipe' else 'nenhuma registrada' end);
 if not exists(select 1 from public.resumos_conversa where conversa_id=_conversa_id and user_id=auth.uid()) then
 insert into public.resumos_conversa(user_id,conversa_id,resumo) values(auth.uid(),_conversa_id,texto);
 end if;
 delete from public.mensagens where conversa_id=_conversa_id and user_id=auth.uid();
end $$;
revoke all on function public.salvar_resumo_seguro(uuid,text[]) from public;
grant execute on function public.salvar_resumo_seguro(uuid,text[]) to authenticated;

comment on table public.mensagens is 'DEPRECATED for short memory: future chat messages stay in browser RAM only';
revoke insert,update on public.mensagens from authenticated;