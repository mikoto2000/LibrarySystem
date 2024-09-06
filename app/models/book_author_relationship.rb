class BookAuthorRelationship < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[book_master_id author_id id created_at updated_at]
  end
  belongs_to :book_master
  belongs_to :author
end
