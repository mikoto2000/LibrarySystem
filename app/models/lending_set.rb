class LendingSet < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[customer_id book_stock_id lending_status_id lend_start_date return_deadline_date return_date memo id created_at updated_at]
  end
  def self.ransackable_associations(auth_object = nil)
    ["book_stocks", "customer", "lending", "lending_status"]
  end
  belongs_to :customer
  belongs_to :lending_status

  has_many :lending
  has_many :book_stocks, through: :lending
end
