# The NOBE Murder Mystery: A Database Escape Room

A hands-on SQL workshop where teams solve a mystery by running real SELECT, UPDATE, DELETE, and INSERT commands against a shared Supabase database.

---

## Part 1: Admin Setup (do this once per class, before the workshop)

You need one Supabase project per class (4 total if running 4 classes). Repeat every step below in each project.

### Step 1 — Create a Supabase project
Go to [supabase.com](https://supabase.com), create an account if you don't have one, and start a new project for this class. Wait for it to finish provisioning (~1-2 minutes).

### Step 2 — Run the setup SQL files, in order
In the Supabase dashboard, open **SQL Editor** in the left sidebar. For each file below, paste its full contents into a new query and click **Run**:

1. `create_tables.sql` — creates `suspects`, `security_footage`, `lab_results`, `envelope`, `leaderboard`
2. `policies.sql` — sets up row-level security so the leaderboard is readable/writable by everyone
3. `04_run_sql_functions.sql` — creates the `run_sql` and `run_sql_write` functions that let participants run literal SQL from the webpage safely

If you hit an "already exists" error on any table or policy, that piece was already created in an earlier run — safe to skip that specific statement and continue with the rest.

### Step 3 — Disable RLS on the puzzle tables (not the leaderboard)
Run this once:
```sql
alter table suspects disable row level security;
alter table security_footage disable row level security;
alter table lab_results disable row level security;
alter table envelope disable row level security;
```
(`leaderboard` should keep RLS enabled from `policies.sql` — that's intentional.)

### Step 4 — Get your project credentials
Go to **Settings → API**. Copy:
- **Project URL** (looks like `https://xxxxxxxxxxxx.supabase.co`)
- **anon public key** (a long string under "Project API keys")

### Step 5 — Plug credentials into index.html
Open `index.html` in a text editor, find near the bottom:
```javascript
const SUPABASE_URL = 'YOUR_SUPABASE_URL';
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';
```
Replace both with the values from Step 4.

### Step 6 — Host the page so participants can reach it
Pick one:
- **GitHub Pages** — push `index.html` to your repo, enable Pages in Settings → Pages, deploy from your main branch. You'll get a URL like `https://yourusername.github.io/your-repo/`
- **Netlify / Vercel** — drag-and-drop `index.html` or connect your repo, get a live URL in under a minute

Each class needs its own copy of `index.html` (with that class's own URL/key) hosted at its own link, since each class has a separate Supabase project and a separate leaderboard.

### Step 7 — Test it yourself before the real workshop
Open your hosted link, enter a test team name (e.g. `TestTeam`), and walk through the full puzzle (see Part 2 below) to confirm everything works end to end.

### Step 8 — Reset before each real class
Before participants arrive, clear out any test data so the leaderboard starts empty:
```sql
delete from suspects;
delete from security_footage;
delete from lab_results;
delete from envelope;
delete from leaderboard;
```

---

## Part 2: Participant Instructions

### Getting started
1. Open the link your instructor gives you
2. Type your team name in the box and click **Begin Investigation**
3. This creates your team's own private copy of all the case data — no other team can see or affect your rows

### How to solve the case
Every query you run needs to include `where team_name = 'YOUR_TEAM_NAME'` (use your **exact** team name, in single quotes) so you're only ever looking at your own data.

### Common mistakes
- **Forgetting quotes around text values** — `where team_name = YOUR_TEAM_NAME` will error; it needs to be `where team_name = 'YOUR_TEAM_NAME'`
- **Typos in your team name** — if a query "succeeds" but nothing seems to change, double-check your team name matches exactly (check with a `select * from envelope` to see the exact stored value)
- **Using the wrong button** — use **Run SELECT** for read-only queries, and **Run INSERT / UPDATE / DELETE** for anything that changes data

### Getting unstuck
If you're not sure what a query should look like, ask your instructor — every SQL command you need is one of the four listed above (SELECT, UPDATE, DELETE, INSERT), just aimed at a different table.
