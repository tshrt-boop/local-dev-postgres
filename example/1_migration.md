# 移行

## 流れ

1. 移行元からのデータ取得
  1. 定義のみ
  2. データのみ
  3. ユーザ情報
2. 移行先へデータ投入
  1. SQL
  2. テキスト(`\COPY`コマンドの結果)
3. その他
  1. パスワードの入力
  2. データの展開
4. 参考

## 移行元からのデータ取得

データサイズが大きい場合、負荷＆時間がかかってしまうので、
定義情報だけ抜き出し、データは必要な分だけ取得するようにします。

### 定義のみ抽出

`-s`オプションで定義のみを抽出できます。

```sh
pg_dump -U postgres -d postgres -h [hostname] -n atlasaz -s >> 1_schema_dump.sql
```

### データのみ抽出

`--data-only`オプションでデータのみを抽出できます。また、
`--table [tablename]`オプションで指定のテーブルのみを抽出できます。

```sh
pg_dump -U postgres -d postgres -h [hostname] -n atlasaz --data-only --table atlasaz.az_voice_youyaku >> az_voice_youyaku.sql
```

データの絞り込みが必要な場合は、psqlコマンドの `\COPY` を使います。
psqlコマンドなので、対象のデータベースサーバにあらかじめログインしておく必要があります。  
SQLで出力されるpg_dumpの結果と違い、テキストで出力される点に注意してください。

```sql
\copy (select * from atlasaz.az_voice where (az_voice.json::json->>'uktk_shiten') = '北見') to 'az_voice.txt' encoding 'UTF8';
```

よく似たものに `COPY`文があります。こちらはデータベースサーバー上のファイルに対しての入出力を行うためのものなので、
RDSなどシェルでログインできないものには利用できません。


### ユーザ情報の抽出

データベース、ユーザー情報は pg_dump では取得されないので、個別に取得してください。 
(pg_dumpallを利用することで取得できるようですが、利用していません)  
特に、ユーザー情報は `search_path` (Oracleのシノニムに近いもの)の情報が必要になるケースがあるので注意してください。

PGAdminが利用できる環境であれば、そこからSQLを確認するのが簡単です。


## 移行先へデータ投入

### SQL

標準入力からリダイレクトしてください。

```sh
psql -U postgres -d postgres -h [hostname] < [filename]
```

### テキスト(`\COPY`コマンドの結果)

```sql
\copy atlasaz.az_voice FROM 'az_voice.txt' encoding 'UTF8';
```

## その他

### パスワードの入力

環境変数 `PGPASSWORD` を設定すると、パスワード入力の代わりにこの値が使われます。
データの投入など、何度もパスワードを入力しなければならない場合などに便利です。

### データの展開

データの展開はバックアップ・リストアの方式を使ったほうが早いです。
[基礎編](./0_basic.md)の内容も参考にしてください。


## 参考

- [PostgreSQL の COPY コマンドを使いこなす](http://everything-you-do-is-practice.blogspot.com/2017/10/postgresql-copy.html)
- 