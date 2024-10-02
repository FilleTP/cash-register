require 'rails_helper'

RSpec.describe 'LineItems', type: :request do
  describe 'POST /products/:product_id/line_items' do
    let!(:product) { create(:product) }
    it 'creates a line item and redirects' do
      post product_line_items_path(product), params: { line_item: { quantity: 2 } }

      expect(response).to have_http_status(:redirect)

      expect(LineItem.last.product).to eq(product)
      expect(LineItem.last.quantity).to eq(2)
    end
  end

  describe 'DELETE /line_items/:id' do
    let!(:cart) { create(:cart) }
    let!(:product) { create(:product) }
    let!(:line_item) { create(:line_item, cart: cart, product: product, quantity: 1) }

    it 'deletes a line item and redirects' do
      delete line_item_path(line_item)

      expect(response).to have_http_status(:redirect)
      expect { line_item.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
