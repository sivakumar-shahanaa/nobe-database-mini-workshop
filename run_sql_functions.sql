-- 04_run_sql_functions.sql
-- Run this once in the Supabase SQL Editor (admin side), after your other setup files.
-- These functions let the participant-facing webpage send literal SQL commands,
-- restricted to only the puzzle tables so nothing outside the workshop can be touched.

-- Helper: reject any query that doesn't mention one of the allowed tables.
-- This is a basic safety net, not bulletproof security -- fine for a classroom
-- exercise, not something to reuse for anything with real data.
create or replace function is_query_allowed(sql_text text)
returns boolean as $$
begin
  return sql_text ~* '\y(suspects|security_footage|lab_results|envelope|leaderboard)\y'
     and sql_text !~* '\y(drop|truncate|alter|grant|revoke|create)\y';
end;
$$ language plpgsql immutable;

-- For SELECT-style queries. Returns rows as JSON.
create or replace function run_sql(sql_text text)
returns json as $$
declare
  result json;
begin
  if not is_query_allowed(sql_text) then
    raise exception 'Query not allowed. Only SELECT statements on suspects, security_footage, lab_results, envelope, or leaderboard are permitted.';
  end if;

  execute format('select coalesce(json_agg(t), ''[]''::json) from (%s) t', sql_text) into result;
  return result;
exception when others then
  return json_build_object('error', SQLERRM);
end;
$$ language plpgsql security definer;

grant execute on function run_sql(text) to anon;

-- For INSERT / UPDATE / DELETE. Returns a plain success/error message.
create or replace function run_sql_write(sql_text text)
returns text as $$
begin
  if not is_query_allowed(sql_text) then
    return 'Error: Query not allowed. Only INSERT, UPDATE, or DELETE on suspects, security_footage, lab_results, envelope, or leaderboard are permitted.';
  end if;

  execute sql_text;
  return 'Success';
exception when others then
  return 'Error: ' || SQLERRM;
end;
$$ language plpgsql security definer;

grant execute on function run_sql_write(text) to anon;