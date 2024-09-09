class NdcCategory < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[name number id created_at updated_at]
  end

  validates :name, presence: true
  validates :number, presence: true, numericality: { only_integer: true }, uniqueness: true
end
