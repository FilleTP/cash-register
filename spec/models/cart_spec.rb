require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      cart = Cart.new(total_price: 1.0)
      expect(cart).to be_valid
    end

    it 'is not valid with price less than 0' do
      cart = Cart.new(total_price: -1.0)
      expect(cart).to_not be_valid
    end
  end

  describe 'default values' do
    it 'gets created with default value 0 for total price' do
      cart = Cart.new
      expect(cart.total_price).to be(0.0)
    end
  end

  describe 'associations' do
    it { should have_many(:line_items).dependent(:destroy) }
  end
end
