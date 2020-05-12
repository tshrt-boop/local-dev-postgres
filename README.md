# Postgresの環境を作る

## TODO

- [ ] READMEの整備

## 前提

- Dockerがインストールされていること
  - docker, docker-composeが利用できる状態
- psqlが利用できる状態であること

この環境ではDockerのボリューム機能を利用します。
Windowsでこの機能を利用するには、Shared Drivesの設定が必要になります。
下記のサイトなどを参考に設定してみてください(基本的にはチェックボックス付ければ終わります)。

- [Docker for Windows で Shared Drives のチェックが入らないときの対処法 - Qiita](https://qiita.com/Targityen/items/2c4840fc900d8f9ce11f)


## 起動

```
docker-compose up -d
```

## 接続確認

```
docker-compose exec db psql -U postgres -d postgres
```

psql内

```
select * from az_groonga.test;
```


## Foreign Data Wrapper について

別のPostgresのテーブルをローカルテーブルと同じように扱える機能。
OracleでいうとDBLINK機能っぽいもの。

接続するには「サーバ情報」「ユーザー情報」を作った上で、
「外部テーブル(＝繋ぎたいテーブル情報)」を作る必要がある。

注意点として、外部テーブル自体は接続先のテーブルと異なる定義をしてもエラーが発生しない。
エラーは外部テーブルにCRUDした時点で発生する。  
また、接続先のテーブルの定義が変更されても外部テーブルは更新されないため、同じ内容で外部テーブルについても定義変更が必要になる。  

複数のテーブルに対して外部テーブルを作成する場合は、`IMPORT FOREIGN SCHEMA`文を使うと便利である。
この文は接続先の指定したスキーマに定義されているテーブルの定義情報を読み取り、指定したスキーマに外部テーブルを作成する。  
`LIMIT TO`句を使えば対象のテーブルを限定することも可能。  
接続先のテーブルに変更があった場合は、一度外部テーブルを削除した上で再度インポートする方法でも定義を更新できる。

## PGPASSWORD

サーバからパスワードを聞かれたときに使われる。
このコンテナイメージ経由でpsqlを利用したいときに便利。


## 参考

- [docker-composeでpostgresの環境を作る - Qiita](https://qiita.com/mabubu0203/items/5cdff1caf2b024df1d95)
- [postgres - Docker Hub](https://hub.docker.com/_/postgres)
- [PostgreSQL 9.6 の postgres_fdw について検証してみた | SIOS Tech. Lab](https://tech-lab.sios.jp/archives/8641)



