require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes and have a photo attached' do
      product = build(:product)
      expect(product.photo).to be_attached
      expect(product).to be_valid
    end

    it 'is not valid without a product code' do
      product = build(:product, product_code: nil)
      expect(product).to_not be_valid
    end

    it 'is not valid without a name' do
      product = build(:product, name: nil)
      expect(product).to_not be_valid
    end

    it 'is not valid without a price' do
      product = build(:product, price: nil)
      expect(product).to_not be_valid
    end

    it 'is not valid with a price less than zero' do
      product = build(:product, price: -1.0)
    end
  end

  describe 'associations' do
    it { should have_many(:line_items) }
  end
end
