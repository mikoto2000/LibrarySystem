class CreateBookStocks < ActiveRecord::Migration[7.2]
  def change
    create_table :book_stocks do |t|
      t.references :book_master, null: false, foreign_key: true
      t.references :book_stock_status, null: false, foreign_key: true
      t.text :memo

      t.timestamps
    end
  end
end
