class CreateBookMasters < ActiveRecord::Migration[7.2]
  def change
    create_table :book_masters do |t|
      t.string :isbn
      t.string :title
      t.date :publication_date
      t.references :ndc_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
