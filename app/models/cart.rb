class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy
  validates :total_price, numericality: { greater_than_or_equal_to: 0 }
end
