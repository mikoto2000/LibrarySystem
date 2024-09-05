---
title: Library System
author: mikoto2000
date: 2024/9/5
---

# アプリケーションのひな形作成

以下、 `ya-rails-template` を用いてアプリケーションのひな形を作成する。

- [mikoto2000/ya-rails-template: Rails7 標準の scaffold に、いくつか機能を追加したテンプレートです。](https://github.com/mikoto2000/ya-rails-template)

```sh
rails new LibrarySystem --css=bootstrap -m ./apptemplate.rb -d postgresql
```


# データベース設定を開発環境に合わせて修正する

`config/database.yml`:

```yaml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  host: postgres
  database: public
  username: admin
  password: password

development:
  <<: *default

test:
  <<: *default

production:
  <<: *default
```

# 書籍管理の scaffold 作成

## まずは Category と BookMaster

scaffold 生成。

```sh
./bin/rails generate scaffold NdcCategory name:string number:integer
./bin/rails generate scaffold BookMaster isbn:string title:string publication_date:date ndc_category:references
```

db マイグレーション。

```sh
./bin/rails db:migrate
```

動作確認。パーミッションの関係で sudo 付きで実行。

```sh
sudo BINDING=0.0.0.0 ./bin/dev
```
