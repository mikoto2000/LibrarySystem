class BookMaster < ApplicationRecord
  include CsvImportable

  def self.ransackable_attributes(_auth_object = nil)
    %w[isbn title publication_date ndc_category_id author_id id created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[authors book_author_relationship ndc_category]
  end

  validates :isbn, presence: true, uniqueness: true, isbn_format: true
  validates :title, presence: true
  validates :publication_date, presence: true
  validates :ndc_category, presence: true

  belongs_to :ndc_category
  has_many :book_author_relationship
  has_many :authors, through: :book_author_relationship

  before_save :normalize_isbn

  private

  def normalize_isbn
    self.isbn = isbn.delete('-')
  end
end
