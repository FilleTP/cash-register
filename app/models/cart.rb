class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def total_price
    PricingRules.new(self).calculate_discounts
  end
end
