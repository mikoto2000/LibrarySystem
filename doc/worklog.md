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

db へ初期値を入力。
`db/seeds.rb` へ初期値入力処理を記載したうえで、以下を実行。

```sh
./bin/rails db:seed
```

## Author と BookAuthorRerationship

### 生成

Author の scaffold 生成。

```sh
./bin/rails generate scaffold Author name:string
```

BookAuthorRerationship のモデルを生成

```sh
./bin/rails generate model BookAuthorRelationship book_master:references author:references
```

### 生成されたものの修正

#### モデル

`app/models/author.rb`:

```rb
class Author < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[name id created_at updated_at]
  end

  # book_author_relationship を通して多対多になる BookStock の設定を記述
  has_many :book_author_relationship                         # 中間テーブルへの関連を定義
  has_many :book_masters, through: :book_author_relationship # 中間テーブルの先の関連を定義
end
```

`app/model/book_master.rb`:

```rb
class BookMaster < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
   # author_id を追加
   %w[isbn title publication_date ndc_category_id author_id id created_at updated_at]
 end

 # Ransack がアソシエーションを認識するための設定の追加
 def self.ransackable_associations(auth_object = nil)
   ["authors", "book_author_relationship", "ndc_category"]
  end
  belongs_to :ndc_category

  # book_author_relationship を通して多対多になる BookStock の設定を記述
  has_many :book_author_relationship                    # 中間テーブルへの関連を定義
  has_many :authors, through: :book_author_relationship # 中間テーブルの先の関連を定義
end
```

#### コントローラー

`app/controllers/book_masters_controller.rb`:

```rb
...(snip)
    # Only allow a list of trusted parameters through.
    def book_master_params
      # リクエストパラメーターに `{author_ids: []}` を追加
      # (author_id の配列)
      params.require(:book_master).permit(:isbn, :title, :publication_date, :ndc_category_id, {author_ids: []})
    end
end
```

#### ビュー

`app/views/book_masters/_form.html.erb`:

```rb
...(snip)
  <%
    # この div ブロックを追加
    # 複数選択のセレクトフィールドで、
    # この書籍の author を選択する。
  %>
  <div>
    <%= form.label :author %>
    <div class="ps-2">
      <%= form.collection_select(
            :author_ids,
            Author.all,
            :id,
            :name,
            { multiple: true, include_blank: "選択なし" }
          ) %>
    </div>
  </div>
...(snip)
```


`app/views/book_masters/index.html.erb`:

検索フィールド追加。

```rb
        <%
          # この div ブロックを追加
          # 複数選択のセレクトフィールドで、
          # 選択したモノを持つ要素を抽出する。
        %>
        <div>
          <%= f.label :author.to_s + "_in".to_s %>
          <div class="ps-2">
            <%= f.collection_select(
                  :book_author_relationship_author_id.to_s + "_in".to_s,
                  Author.all,
                  :id,
                  :name,
                  {},
                  { multiple: true }
                ) %>
          </div>
        </div>
```

テーブルヘッダ―の追加。

```rb
        <th><%= sort_link(@q, :author, default_order: :asc, class: "d-block") %></th>
```

テーブルボディの追加。

```rb
          <td><%= book_master.authors.map{|author| author.name }.join(", ") %></td>
```

`app/views/book_masters/_book_master.html.erb`:

author 行の追加。

```rb
    <tr>
      <td>
        <strong>
          <%= BookMaster.human_attribute_name(:author) %>
        </strong>
      </td>
      <td>
        <%= book_master.authors.map{|a| a.name}.join(", ") %>
      </td>
    </tr>
```


#### db マイグレーション

```sh
./bin/rails db:migrate
```

#### 動作確認

```sh
sudo BINDING=0.0.0.0 ./bin/dev
```

# 貸出管理

## まずは在庫ステータスと在庫

### scaffold の作成

```sh
./bin/rails generate scaffold BookStockStatus name:string
./bin/rails generate scaffold BookStock book_master:references book_stock_status:references memo:text
```

### scaffold の修正

`app/views/book_stocks/index.html.erb`:

`book_master` の `name` を `title` に変更。

`app/views/book_stocks/_book_master.html.erb`:

`<%= book_stock.book_master.name %>` を `<%= book_stock.book_master.title %>` に変更。

`app/views/book_stocks/_form.html.erb`:

`book_stock` の `:name` を `:title` に変更。


### seed 作成

```rb
BookStockStatus.create!([
  {
    name: "貸出可能",
  },
  {
    name: "貸出中",
  },
  {
    name: "貸出不可",
  },
  {
    name: "破棄",
  }
])
```

### db マイグレーション

```sh
./bin/rails db:drop
./bin/rails db:create
./bin/rails db:migrate
./bin/rails db:seed
```

### 動作確認

```sh
sudo BINDING=0.0.0.0 ./bin/dev
```

# 貸出管理の scaffold 作成

## 顧客と貸出(伝票？)周り

scaffold 作成。

```sh
./bin/rails generate scaffold Customer name:string email_address:string
./bin/rails generate scaffold LendingStatus name:string
./bin/rails generate scaffold LendingSet customer:references lending_status:references lend_start_date:date return_deadline_date:date return_date:date memo:text
```

### seed 作成

```rb
LendingStatus.create!([
  {
    name: "貸出中",
  },
  {
    name: "貸出期限超過",
  },
  {
    name: "返却済",
  }
])
```

## 動作確認

```sh
sudo BINDING=0.0.0.0 ./bin/dev
```

# LendingSet と BookStock の関連を追加

## model の作成

```sh
./bin/rails generate model Lending lending_set:references book_stock:references
```

## マイグレーション

```sh
./bin/rails db:migrate
```


# 貸出(伝票？)と BookStock の関連を追加

## モデルの生成

```sh
./bin/rails generate model Lending lending_set:references book_stock:references
```

### 生成されたものの修正

#### モデル

`app/model/lending_set.rb`:

```rb
class LendingSet < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    # `book_stock_id` を追加
    %w[customer_id book_stock_id lending_status_id lend_start_date return_deadline_date return_date memo id created_at updated_at]
  end

 # Ransack がアソシエーションを認識するための設定の追加
  def self.ransackable_associations(auth_object = nil)
    ["book_stocks", "customer", "lending", "lending_status"]
  end
  belongs_to :customer
  belongs_to :lending_status

  # lending を通して多対多になる BookStock の設定を記述
  has_many :lending                        # 中間テーブルへの関連を定義
  has_many :book_stocks, through: :lending # 中間テーブルの先の関連を定義
end
```

`app/model/book_stock.rb`:

```rb
class BookStock < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[book_master_id book_stock_status_id memo id created_at updated_at]
  end
  belongs_to :book_master
  belongs_to :book_stock_status

  # lending を通して多対多になる BookStock の設定を記述
  has_many :lending                    # 中間テーブルへの関連を定義
  has_many :ng_sets, through: :lending # 中間テーブルの先の関連を定義
end
```

#### コントローラー

`app/controllers/lending_sets_controller.rb`:

```rb
...(snip)
    # Only allow a list of trusted parameters through.
    def lending_set_params
      # `{book_stock_ids: []}` を追加
      params.require(:lending_set).permit(:customer_id, :lending_status_id, :lend_start_date, :return_deadline_date, :return_date, :memo, {book_stock_ids: []})
    end
end
```

#### ビュー

`app/views/book_masters/_form.html.erb`:

```rb
...(snip)
  <%
    # この div ブロックを追加
    # 複数選択のセレクトフィールドで、
    # この貸出するの book_stock を選択する。
  %>
  <div>
    <%= form.label :book_stocks %>
    <div class="ps-2">
      <%= form.collection_select(
            :book_stock_ids,
            BookStock.all.map {|bs| [bs.id, bs.id.to_s + ":" + bs.book_master.title]},
            :first,
            :last,
            { multiple: true }
          ) %>
    </div>
  </div>
...(snip)
```


`app/views/book_masters/index.html.erb`:

検索フィールド追加。

```rb
        <%
          # この div ブロックを追加
          # 複数選択のセレクトフィールドで、
          # 選択したモノを持つ要素を抽出する。
        %>
        <div>
          <%= f.label :book_stock.to_s + "_in".to_s %>
          <div class="ps-2">
            <%= f.collection_select(
                  :lending_book_stock_id.to_s + "_in".to_s,
                  BookStock.all.map {|bs| [bs.id, bs.id.to_s + ":" + bs.book_master.title]},
                  :first,
                  :last,
                  {},
                  { multiple: true }
                ) %>
          </div>
        </div>
```

テーブルヘッダ―の追加。

```rb
        <th><%= sort_link(@q, :title, default_order: :asc, class: "d-block") %></th>
```

テーブルボディの追加。

```rb
          <td><%= lending_set.book_stocks.map {|book_stock| book_stock.book_master.title }.join(", ") %></td>
```

`app/views/book_masters/_lending_set.html.erb`:

タイトル行の追加。

```rb
    <tr>
      <td>
        <strong>
          <%= LendingSet.human_attribute_name(:book_stock) %>
        </strong>
      </td>
      <td>
        <%= lending_set.book_stocks.map{|bs| bs.id.to_s + ":" + bs.book_master.title}.join(", ") %>
      </td>
    </tr>
```

