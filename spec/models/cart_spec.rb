require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe '#total_price' do
    let!(:cart) { create(:cart) }
    it 'returns 0 for a cart with no line items' do
      expect(cart.total_price).to eq(0)
    end
  end
  describe 'associations' do
    it { should have_many(:line_items).dependent(:destroy) }
  end
end
