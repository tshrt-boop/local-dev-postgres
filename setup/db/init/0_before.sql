create extension postgis;
create extension pg_trgm;
create extension postgres_fdw;

CREATE USER atlasaz WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  CREATEDB
  CREATEROLE
  NOREPLICATION;

ALTER USER postgres SET search_path TO "$user", public, atlasaz;
