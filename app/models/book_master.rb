class BookMaster < ApplicationRecord
  include CsvImportable

  def self.ransackable_attributes(_auth_object = nil)
    %w[isbn title publication_date ndc_category_id author_id id created_at updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[authors book_author_relationship ndc_category]
  end

  # TODO: ちゃんとした判定ロジックを作る
  VALID_ISBN_PATTERN = /[0-9\-]+/

  validates :isbn, presence: true, uniqueness: true, format: { with: VALID_ISBN_PATTERN }
  validates :title, presence: true
  validates :publication_date, presence: true
  validates :ndc_category, presence: true

  belongs_to :ndc_category
  has_many :book_author_relationship
  has_many :authors, through: :book_author_relationship
end
