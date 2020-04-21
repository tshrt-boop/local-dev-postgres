--サーバーの定義
CREATE SERVER az_groonga FOREIGN DATA WRAPPER postgres_fdw
  OPTIONS (host 'db_fts', dbname 'atlasaz', port '5433');
--ユーザーの定義
CREATE USER MAPPING FOR root SERVER az_groonga OPTIONS (user 'root', password 'root');
--インポート対象の定義(ここではスキーマ)
IMPORT FOREIGN SCHEMA atlasaz FROM SERVER az_groonga INTO az_groonga;

