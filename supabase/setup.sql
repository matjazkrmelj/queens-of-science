-- Queens of Science leaderboard: paste into Supabase > SQL Editor > New query, then Run.
create table if not exists public.scores (
  id bigint generated always as identity primary key,
  name text not null check (char_length(name) between 1 and 16),
  score integer not null check (score between 0 and 200000),
  won boolean not null default false,
  created_at timestamptz not null default now()
);

alter table public.scores enable row level security;

-- Anyone playing the game can read the board and add a score, but nobody can edit or delete scores.
create policy "Anyone can read scores" on public.scores for select to anon using (true);
create policy "Anyone can add a score" on public.scores for insert to anon with check (true);
grant select, insert on public.scores to anon;
