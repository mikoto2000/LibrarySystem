class CreateBookAuthorRelationships < ActiveRecord::Migration[7.2]
  def change
    create_table :book_author_relationships do |t|
      t.references :book_master, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
