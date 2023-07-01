class Public::CartItemsController < ApplicationController
  def index
    @cart_item = CartItem.all
    @total = 0
  end
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_items=current_customer.cart_items.all
        @cart_items.each do |cart_item|
          if cart_item.item_id==@cart_item.item_id
          new_amount = cart_item.amount + @cart_item.amount
          cart_item.update_attribute(:amount, new_amount)
          @cart_item.delete
          end
        end
        @cart_item.save
        redirect_to cart_items_path,notice:"カートに商品が入りました"
  end
  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end
  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end
  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end

end
