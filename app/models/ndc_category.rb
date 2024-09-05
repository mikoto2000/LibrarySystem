class NdcCategory < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[name number id created_at updated_at]
  end
end
