class BookMaster < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[isbn title publication_date ndc_category_id id created_at updated_at]
  end
  belongs_to :ndc_category
end
