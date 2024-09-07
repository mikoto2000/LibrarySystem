class Customer < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[name email_address id created_at updated_at]
  end
end
