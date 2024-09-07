class CreateLendings < ActiveRecord::Migration[7.2]
  def change
    create_table :lendings do |t|
      t.references :lending_set, null: false, foreign_key: true
      t.references :book_stock, null: false, foreign_key: true

      t.timestamps
    end
  end
end
