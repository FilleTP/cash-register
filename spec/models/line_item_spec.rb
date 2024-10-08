require 'rails_helper'

RSpec.describe LineItem, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      line_item = build(:line_item, quantity: 2, price: 5)
      expect(line_item).to be_valid
    end

    it 'is not valid without a cart' do
      line_item = build(:line_item, cart: nil, quantity: 2, price: 5)
      expect(line_item).to_not be_valid
    end

    it 'is not valid without a product' do
      line_item = build(:line_item, product: nil, quantity: 2, price: 5)
      expect(line_item).to_not be_valid
    end

    it 'is not valid with a negative quantity value' do
      line_item = build(:line_item, quantity: -2, price: 5)
      expect(line_item).to_not be_valid
    end

    it 'is not valid with a negative price' do
      line_item = build(:line_item, quantity: 1, price: -2)
      expect(line_item).to_not be_valid
    end
  end

  describe 'default values' do
    it 'gets created with default value 1 for quantity' do
      line_item = build(:line_item)
      expect(line_item).to be_valid
      expect(line_item.quantity).to be(1)
    end

    it 'gets created with default value 0 for price' do
      line_item = build(:line_item)
      expect(line_item).to be_valid
      expect(line_item.price).to be(0.0)
    end
  end

  describe 'associations' do
    it { should belong_to(:cart) }
    it { should belong_to(:product) }
  end
end
