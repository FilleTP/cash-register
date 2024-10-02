class LineItemsController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    line_item = current_cart.line_items.find_by(product: product)

    if line_item
      line_item.quantity += line_item_params[:quantity].to_i
    else
      line_item = current_cart.line_items.build(product: product, quantity: line_item_params[:quantity].to_i, price: product.price)
    end

    respond_to do |format|
      if line_item.save
        flash[:notice] = 'Added to the basket!'
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update("form_product_#{product.id}", partial: 'products/form', locals: { product: product, line_item: LineItem.new }),
            turbo_stream.update('flash', partial: 'shared/flashes')
          ]
        end
        format.html { redirect_to root_path, notice: 'Added to the basket!' }
      else
        flash[:alert] = 'Product could not be added'
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update("form_product_#{product.id}", partial: 'products/form', locals: { product: product, line_item: line_item }),
            turbo_stream.update('flash', partial: 'shared/flashes')
          ], status: :unprocessable_entity
        end
        format.html { render 'products/index', alert: "Product could not be added", status: :unprocessable_entity }
      end
    end
  end

  def destroy
    line_item = LineItem.find(params[:id])
    respond_to do |format|
      if line_item.destroy
        flash[:notice] = 'Removed product!'
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('line_items', partial: 'carts/table', locals: { cart: current_cart }),
            turbo_stream.update('flash', partial: 'shared/flashes')
          ]
        end
        format.html { redirect_to cart_path, notice: 'Removed product!' }
      else
        flash[:alert] = 'Product could not be removed'
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('line_items', partial: 'carts/table', locals: { cart: current_cart }),
            turbo_stream.update('flash', partial: 'shared/flashes')
          ], status: :unprocessable_entity
        end
        format.html { render 'carts/show', alert: "Product could not be removed", status: :unprocessable_entity }
      end
    end
  end

  private

  def line_item_params
    params.require(:line_item).permit(:quantity)
  end
end
