alter table leaderboard enable row level security;

create policy "anyone can view leaderboard"
  on leaderboard for select using (true);

create policy "anyone can insert into leaderboard"
  on leaderboard for insert with check (true);