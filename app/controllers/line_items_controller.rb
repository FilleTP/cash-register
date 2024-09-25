class LineItemsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    line_item = current_cart.line_items.find_by(product: product)

    if line_item
      line_item.quantity += line_item_params[:quantity].to_i
    else
      line_item = current_cart.line_items.build(product: product, quantity: line_item_params[:quantity].to_i, price: product.price)
    end

    if line_item.save
      redirect_to root_path, notice: "Added to the basket!"
    else
      render 'products/index', alert: "Product could not be added", status: :unprocessable_entity
    end
  end

  def destroy
    line_item = LineItem.find(params[:id])
    if line_item.destroy
      redirect_to cart_path, notice: "Removed product!"
    else
      render 'carts/show', alert: "Product could not be removed", status: :unprocessable_entity
    end
  end

  private

  def line_item_params
    params.require(:line_item).permit(:quantity)
  end
end
