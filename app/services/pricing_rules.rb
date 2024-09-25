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
    when "GR1" then green_tea_discount(line_item)
    when "SR1" then strawberries_discount(line_item)
    when "CF1" then coffee_discount(line_item)
    else
      line_item.price * line_item.quantity
    end
  end

  def green_tea_discount(line_item)
    if line_item.quantity >= 2
      paid_items = (line_item.quantity / 2) + (line_item.quantity % 2)
      line_item.price * paid_items
    else
      line_item.price * line_item.quantity
    end
  end

  def strawberries_discount(line_item)
    if line_item.quantity >= 3
      line_item.quantity * 4.5
    else
      line_item.price * line_item.quantity
    end
  end

  def coffee_discount(line_item)
    if line_item.quantity >= 3
      line_item.quantity * (line_item.price * (2.0 / 3.0))
    else
      line_item.price * line_item.quantity
    end
  end
end
