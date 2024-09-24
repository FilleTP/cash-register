require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      product = Product.new(product_code: "GR1", name: 'Sample Product', price: 9.99)
      expect(product).to be_valid
    end

    it 'is not valid without a product code' do
      product = Product.new(name: 'Sample Product', price: 9.99)
      expect(product).to_not be_valid
    end

    it 'is not valid without a name' do
      product = Product.new(product_code: "GR1", price: 9.99)
      expect(product).to_not be_valid
    end

    it 'is not valid without a price' do
      product = Product.new(product_code: "GR1", name: 'Sample Product')
      expect(product).to_not be_valid
    end

    it 'is not valid with a price less than zero' do
      product = Product.new(product_code: "GR1", name: 'Sample Product', price: -1.0)
    end
  end

  describe 'associations' do
    it { should have_many(:line_items) }
  end
end
