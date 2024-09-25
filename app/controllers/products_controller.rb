class ProductsController < ApplicationController
  def index
    @products = Product.all
    @line_item = LineItem.new
  end
end
