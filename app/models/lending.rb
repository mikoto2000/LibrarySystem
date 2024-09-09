class Lending < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[lending_set_id book_stock_id id created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[lending_set_id book_stock_id id created_at updated_at]
  end
  belongs_to :lending_set
  belongs_to :book_stock
end
