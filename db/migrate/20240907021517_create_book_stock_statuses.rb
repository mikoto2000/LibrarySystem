class CreateBookStockStatuses < ActiveRecord::Migration[7.2]
  def change
    create_table :book_stock_statuses do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
