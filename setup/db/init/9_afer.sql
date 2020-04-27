--サーバーの定義
CREATE SERVER fts FOREIGN DATA WRAPPER postgres_fdw
  OPTIONS (host 'db_fts', dbname 'postgres', port '5433');
--ユーザーの定義
CREATE USER MAPPING FOR postgres SERVER fts OPTIONS (user 'postgres', password 'root');
--インポート対象の定義(ここではスキーマ)
CREATE SCHEMA az_pgroonga AUTHORIZATION postgres;
IMPORT FOREIGN SCHEMA atlasaz FROM SERVER fts INTO az_pgroonga;

