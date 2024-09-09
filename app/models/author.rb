class Author < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[name id created_at updated_at]
  end

  validates :name, presence: true, uniqueness:true

  has_many :book_author_relationship
  has_many :book_masters, through: :book_author_relationship
end
