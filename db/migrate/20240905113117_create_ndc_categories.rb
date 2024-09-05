class CreateNdcCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :ndc_categories do |t|
      t.string :name
      t.integer :number

      t.timestamps
    end
  end
end
