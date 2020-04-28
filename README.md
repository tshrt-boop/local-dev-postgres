# Postgresの環境を作る

## TODO

- [ ] READMEの整備

## 起動

```
docker-compose up -d
```

## 接続確認

```
docker-compose exec db psql -U root -d atlasaz
```

psql内

```
select * from az_groonga.test;
```


## Foreign Data Wrapper について

別のPostgresのテーブルをローカルテーブルと同じように扱える機能。
OracleでいうとDBLINK機能っぽいもの。

接続するには「サーバ情報」「ユーザー情報」を作った上で、
「繋ぎたいテーブル情報」を作る必要がある。



## PGPASSWORD

サーバからパスワードを聞かれたときに使われる。
このコンテナイメージ経由でpsqlを利用したいときに便利。


## 参考

- [docker-composeでpostgresの環境を作る - Qiita](https://qiita.com/mabubu0203/items/5cdff1caf2b024df1d95)
- [postgres - Docker Hub](https://hub.docker.com/_/postgres)
- [PostgreSQL 9.6 の postgres_fdw について検証してみた | SIOS Tech. Lab](https://tech-lab.sios.jp/archives/8641)



