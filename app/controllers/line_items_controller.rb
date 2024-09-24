class LineItemsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    line_item = current_cart.line_items.find_by(product: product)

    if line_item
      line_item.quantity += line_item_params[:quantity].to_i
    else
      line_item = current_cart.line_items.build(product: product, quantity: line_item_params[:quantity].to_i)
    end

    if line_item.save
      redirect_to root_path, notice: "Added to the basket!"
    else
      render root_path, alert: "Product could not be added"
    end
  end

  private

  def line_item_params
    params.require(:line_item).permit(:quantity)
  end
end
