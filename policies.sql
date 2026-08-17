-- policies.sql will be used to govern access to the leaderboard table

alter table leaderboard enable row level security;

create policy "allow all to see leaderboard" 
  on leaderboard
  for select
  using (true);

create policy "allow all to insert into leaderboard" 
  on leaderboard
  for insert
  with check (
      exists (
      select 1
      from envelope
      where is_locked = false and submitted_code = "SRIKRITI-GUILTY"
    )
  );
    