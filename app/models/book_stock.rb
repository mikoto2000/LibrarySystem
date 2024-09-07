class BookStock < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[book_master_id book_stock_status_id memo id created_at updated_at]
  end
  belongs_to :book_master
  belongs_to :book_stock_status

  has_many :lending
  has_many :ng_sets, through: :lending
end
