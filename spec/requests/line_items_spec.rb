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

end
