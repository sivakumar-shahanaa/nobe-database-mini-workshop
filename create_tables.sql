create table suspects (
  id serial primary key,
  team_name text not null,
  name text,
  letter text,
  alibi_location text,
  alibi_time time,
  alibi_statement text,
  has_alibi boolean
);

create table security_footage (
  id serial primary key,
  team_name text not null,
  location text,
  time_seen time,
  activity text
);

create table lab_results (
  id serial primary key,
  team_name text not null,
  name text,
  polygraph_result text
);

create table envelope (
  id serial primary key,
  team_name text not null unique,
  is_locked boolean default true,
  submitted_code text
);

create table leaderboard (
  team_name text primary key,
  finish_time timestamp default current_timestamp
);