require 'rails_helper'

RSpec.describe 'Cart Flow', type: :system do
  let!(:green_tea) { create(:product, name: 'Green Tea', product_code: 'GR1', price: 3.11) }
  let!(:strawberries) { create(:product, name: 'Strawberries', product_code: 'SR1', price: 5) }
  let!(:coffee) { create(:product, name: 'Coffee', product_code: 'CF1', price: 11.23) }

  context 'create line items' do
    it 'adds several line items to the cart and displays correct price' do
      visit root_path

      within('.product-card-bottom', text: 'Green Tea') do
        fill_in 'line_item_quantity', with: 1
        click_button 'Add'
      end

      within('.product-card-bottom', text: 'Strawberries') do
        fill_in 'line_item_quantity', with: 1
        click_button 'Add'
      end

      within('.product-card-bottom', text: 'Coffee') do
        fill_in 'line_item_quantity', with: 1
        click_button 'Add'
      end

      visit cart_path

      within("tr[id='#{green_tea.id}']") do
        expect(page).to have_selector('td', text: 'Green Tea')
        expect(page).to have_selector('td', text: '3.11')
      end

      within("tr[id='#{strawberries.id}']") do
        expect(page).to have_selector('td', text: 'Strawberries')
        expect(page).to have_selector('td', text: '5')
      end

      within("tr[id='#{coffee.id}']") do
        expect(page).to have_selector('td', text: 'Coffee')
        expect(page).to have_selector('td', text: '11.23')
      end

      total_price = green_tea.price + strawberries.price + coffee.price
      within("#total-price") do
        expect(page).to have_content(total_price)
      end
    end
  end

  context 'remove line items' do
    it 'removes a line item and shows the correct new price' do
      visit root_path

      within('.product-card-bottom', text: 'Green Tea') do
        fill_in 'line_item_quantity', with: 1
        click_button 'Add'
      end

      visit cart_path

      within("tr[id='#{green_tea.id}']") do
        expect(page).to have_selector('td', text: 'Green Tea')
        find("a[data-turbo-method='delete']").click
      end

      expect(page).not_to have_selector("tr[id='#{green_tea.id}']")
      within("#total-price") do
        expect(page).to have_content('0')
      end
    end
  end
end
