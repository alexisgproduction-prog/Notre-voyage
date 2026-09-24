-- NOTRE VOYAGE V3 — migration depuis la V2.1
-- À exécuter une seule fois dans Supabase SQL Editor.

alter table public.flights add column if not exists paid_by text default 'Alexis';
alter table public.flights add column if not exists reserved_by text default 'Alexis';
alter table public.stays add column if not exists paid_by text default 'Alexis';
alter table public.stays add column if not exists reserved_by text default 'Alexis';
alter table public.documents add column if not exists owner_name text default 'Alexis';

create table if not exists public.places (
  id uuid primary key default gen_random_uuid(),
  trip_id uuid not null references public.trips(id) on delete cascade,
  name text not null,
  address text,
  category text,
  lat double precision,
  lng double precision,
  created_at timestamptz default now()
);

create table if not exists public.reminders (
  id uuid primary key default gen_random_uuid(),
  trip_id uuid not null references public.trips(id) on delete cascade,
  title text not null,
  date date not null,
  time time,
  type text default 'Autre',
  created_at timestamptz default now()
);

alter table public.places enable row level security;
alter table public.reminders enable row level security;

drop policy if exists "places_select_members" on public.places;
drop policy if exists "places_insert_members" on public.places;
drop policy if exists "places_delete_members" on public.places;
drop policy if exists "reminders_select_members" on public.reminders;
drop policy if exists "reminders_insert_members" on public.reminders;
drop policy if exists "reminders_delete_members" on public.reminders;

create policy "places_select_members" on public.places for select using (exists (select 1 from public.trip_members m where m.trip_id=places.trip_id and m.user_id=auth.uid()));
create policy "places_insert_members" on public.places for insert with check (exists (select 1 from public.trip_members m where m.trip_id=places.trip_id and m.user_id=auth.uid()));
create policy "places_delete_members" on public.places for delete using (exists (select 1 from public.trip_members m where m.trip_id=places.trip_id and m.user_id=auth.uid()));
create policy "reminders_select_members" on public.reminders for select using (exists (select 1 from public.trip_members m where m.trip_id=reminders.trip_id and m.user_id=auth.uid()));
create policy "reminders_insert_members" on public.reminders for insert with check (exists (select 1 from public.trip_members m where m.trip_id=reminders.trip_id and m.user_id=auth.uid()));
create policy "reminders_delete_members" on public.reminders for delete using (exists (select 1 from public.trip_members m where m.trip_id=reminders.trip_id and m.user_id=auth.uid()));

insert into storage.buckets (id,name,public) values ('trip-documents','trip-documents',true) on conflict (id) do nothing;

drop policy if exists "trip_docs_select" on storage.objects;
drop policy if exists "trip_docs_insert" on storage.objects;
drop policy if exists "trip_docs_delete" on storage.objects;
create policy "trip_docs_select" on storage.objects for select using (bucket_id='trip-documents');
create policy "trip_docs_insert" on storage.objects for insert to authenticated with check (bucket_id='trip-documents');
create policy "trip_docs_delete" on storage.objects for delete to authenticated using (bucket_id='trip-documents');

-- Les colonnes paid_by/reserved_by sont utilisées par V3.
