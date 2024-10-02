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
    when "IC1" then buy_four_get_three_fourths_off_each(line_item)
    when "CF1" then buy_four_get_three_fourths_off_each(line_item)
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

  def buy_four_get_three_fourths_off_each(line_item)
    coffees_quantity = @cart.line_items
      .select { |line_item| ["CF1", "IC1"].include?(line_item.product.product_code) }
      .sum(&:quantity)

    if coffees_quantity >= 4
      line_item.price = line_item.quantity * (line_item.price * 0.25)
    else
      line_item.price * line_item.quantity
    end
  end
end
