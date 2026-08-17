-- create_tables.sql initializes the database schema for the puzzle

create table suspects (
  "letter" text,
  "name" text,
  "alibi_location" text,
  "alibi_time" time,
  "alibi_statement" text,
  "has_alibi" boolean
);

create table security_footage (
  "location" text primary key,
  "time_seen" time,
  "activity" text
);

create table polygraph_results (
  "suspect_name" text primary key,
  "polygraph_result" text
);

create table envelope (
    "is_locked" boolean,
    "submitted_code" text
);

create table leaderboard (
    "team_name" text primary key,
    "finish_time" timestamp default current_timestamp
);


