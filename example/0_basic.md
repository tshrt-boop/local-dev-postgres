# 起動・終了と接続

## 起動と終了

```sh
# コンテナ作成 & 起動
docker-compose up -d
# コンテナ停止
docker-compose stop
# コンテナ起動
docker-compose start
# コンテナ停止 & 削除
docker-compose down
```

データはコンテナ内に格納されているので、
コンテナを削除するとDBのデータも初期化される点に注意してください。


## 接続

### psqlコマンドで

```sh
# 汎用側
docker-compose exec db psql -U root -d atlasaz
# 全文検索側
docker-compose exec db_fts psql -U root -d atlasaz
```

## バックアップと復旧

データは `./data` 以下に保存されているので、
ここをバックアップしておけばOKです。  
バックアップしたファイルを他のマシンに展開すれば、
データの展開も可能です。

```sh
# バックアップ
# 汎用は data/db 全文検索 は data/db_fts
zip -r bk_fts.zip data/db_fts
# 展開
unzip bk_fts.zip 
```

### メモ

```sql
insert into atlasaz.test values (2, 'fuga');
insert into az_groonga.test values (2, 'fuga');
select * from atlasaz.test;
select * from az_groonga.test;
```
