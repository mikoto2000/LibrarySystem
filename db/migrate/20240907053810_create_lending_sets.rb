class CreateLendingSets < ActiveRecord::Migration[7.2]
  def change
    create_table :lending_sets do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :lending_status, null: false, foreign_key: true
      t.date :lend_start_date
      t.date :return_deadline_date
      t.date :return_date
      t.text :memo

      t.timestamps
    end
  end
end
