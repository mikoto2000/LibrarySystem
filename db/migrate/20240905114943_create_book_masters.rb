class CreateBookMasters < ActiveRecord::Migration[7.2]
  def change
    create_table :book_masters do |t|
      t.string :isbn, null: false
      t.string :title, null: false
      t.date :publication_date, null: false
      t.references :ndc_category, null: false, foreign_key: true

      t.timestamps
    end
    add_index :book_masters, [:isbn], unique: true
  end
end
