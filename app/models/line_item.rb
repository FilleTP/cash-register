class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart
  validates :quantity, numericality: { greater_than: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
