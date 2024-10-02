require 'rails_helper'

RSpec.describe PricingRules, type: :service do
  let(:cart) { create(:cart) }
  let(:green_tea) { create(:product, name: 'Green Tea', product_code: 'GR1', price: 3.11) }
  let(:strawberries) { create(:product, name: 'Strawberries', product_code: 'SR1', price: 5) }
  let(:coffee) { create(:product, name: 'Coffee', product_code: 'CF1', price: 11.23) }
  let(:ice_coffee) { create(:product, name: 'Ice Coffee', product_code: 'IC1', price: 10.50) }

  it 'applies green tea buy one get one free discount for 4 teas' do
    create(:line_item, cart: cart, product: green_tea, quantity: 4, price: green_tea.price)
    expected_price = (4 / 2) * green_tea.price
    total_price = PricingRules.new(cart).calculate_discounts
    expect(total_price).to eq(expected_price.round(2))
  end

  it 'applies strawberry bulk discount for 3 strawberries' do
    create(:line_item, cart: cart, product: strawberries, quantity: 3, price: strawberries.price)
    expected_price = 4.5 * 3
    total_price = PricingRules.new(cart).calculate_discounts
    expect(total_price).to eq(expected_price.round(2))
  end

  it 'applies 75% coffee discount for all coffees if total coffee product quantity is more or equal to 4' do
    create(:line_item, cart: cart, product: ice_coffee, quantity: 1, price: ice_coffee.price)
    create(:line_item, cart: cart, product: coffee, quantity: 3, price: coffee.price)
    expected_price = (ice_coffee.price + coffee.price * 3) / 4
    total_price = PricingRules.new(cart).calculate_discounts
    expect(total_price).to eq(expected_price.round(2))
  end

  it 'applies multiple discounts for cart with more than 1 line item' do
    create(:line_item, cart: cart, product: green_tea, quantity: 5, price: green_tea.price)
    create(:line_item, cart: cart, product: strawberries, quantity: 8, price: strawberries.price)
    create(:line_item, cart: cart, product: coffee, quantity: 3, price: coffee.price)
    create(:line_item, cart: cart, product: ice_coffee, quantity: 5, price: ice_coffee.price)

    green_tea_total = 3 * green_tea.price
    strawberries_total = 4.5 * 8
    ice_coffe_total = ice_coffee.price * 5 / 4
    coffee_total = coffee.price * 3 / 4

    expected_price = green_tea_total + strawberries_total + coffee_total + ice_coffe_total
    total_price = PricingRules.new(cart).calculate_discounts
    expect(total_price).to eq(expected_price.round(2))
  end

  it 'does not apply discounts if its not applicable' do
    create(:line_item, cart: cart, product: green_tea, quantity: 1, price: green_tea.price)
    create(:line_item, cart: cart, product: strawberries, quantity: 2, price: strawberries.price)
    create(:line_item, cart: cart, product: coffee, quantity: 2, price: coffee.price)

    expected_price = green_tea.price + (strawberries.price * 2) + (coffee.price * 2)
    total_price = PricingRules.new(cart).calculate_discounts
    expect(total_price).to eq(expected_price.round(2))
  end
end
