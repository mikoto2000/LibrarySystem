class LendingSet < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[customer_id book_stock_id lending_status_id lend_start_date return_deadline_date return_date memo id created_at updated_at]
  end
  def self.ransackable_associations(auth_object = nil)
    ["book_stocks", "customer", "lending", "lending_status"]
  end

  after_save do
    if self.lending_status.name === "貸出中"
      self.book_stocks.each {|bs|
          bs.book_stock_status_id = 2
          bs.save
      }
    elsif self.lending_status.name === "返却済"
      self.book_stocks.each {|bs|
          bs.book_stock_status_id = 1
          bs.save
      }
    end
  end

  validates :book_stocks, presence: true
  validates :lend_start_date, presence: true, date: true
  validates :return_deadline_date, presence: true, date: { after: :lend_start_date }
  validates :return_date, date: { allow_blank: true }

  belongs_to :customer
  belongs_to :lending_status

  has_many :lending
  has_many :book_stocks, through: :lending
end
