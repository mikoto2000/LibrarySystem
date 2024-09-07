class LendingSet < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[customer_id lending_status_id lend_start_date return_deadline_date return_date memo id created_at updated_at]
  end
  belongs_to :customer
  belongs_to :lending_status
end
