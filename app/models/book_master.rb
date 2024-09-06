class BookMaster < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[isbn title publication_date ndc_category_id author_id id created_at updated_at]
  end
  def self.ransackable_associations(auth_object = nil)
    ["authors", "book_author_relationship", "ndc_category"]
  end
  belongs_to :ndc_category
  has_many :book_author_relationship
  has_many :authors, through: :book_author_relationship
end
