class PricingRules

  def initialize(cart)
    @cart = cart
  end

  def calculate_discounts
    total = 0
    @cart.line_items.each do |line_item|
      total += discounted_price(line_item)
    end
    total.round(2)
  end

  def discounted_price(line_item)
    case line_item.product.product_code
    when "GR1" then buy_one_get_one_free(line_item)
    when "SR1" then bulk_discount_percentage_off(line_item, 3, 0.10)
    else
      line_item.price * line_item.quantity
    end
  end

  def buy_one_get_one_free(line_item)
    if line_item.quantity >= 2
      paid_items = (line_item.quantity / 2) + (line_item.quantity % 2)
      line_item.price * paid_items
    else
      line_item.price * line_item.quantity
    end
  end

  def bulk_discount_percentage_off(line_item, min_quantity, discount_percentage)
    if line_item.quantity >= min_quantity
      line_item.quantity * (line_item.price * (1 - discount_percentage))
    else
      line_item.price * line_item.quantity
    end
  end
end
