require 'rails_helper'

RSpec.describe LineItem, type: :model do
  describe 'validations' do
    let(:cart) { create(:cart) }
    let(:product) { create(:product) }

    it 'is valid with valid attributes' do
      line_item = LineItem.new(cart: cart, product: product, quantity: 2)
      expect(line_item).to be_valid
    end

    it 'is not valid without a cart' do
      line_item = LineItem.new(product: product, quantity: 2)
      expect(line_item).to_not be_valid
    end

    it 'is not valid without a product' do
      line_item = LineItem.new(cart: cart, quantity: 2)
      expect(line_item).to_not be_valid
    end
  end

  describe 'default values' do
    let(:cart) { create(:cart) }
    let(:product) { create(:product) }
    it 'gets created with default value 1 for quantity' do
      line_item = LineItem.new(cart: cart, product: product)
      expect(line_item).to be_valid
      expect(line_item.quantity).to be(1)
    end
  end

  describe 'associations' do
    it { should belong_to(:cart) }
    it { should belong_to(:product) }
  end
end
