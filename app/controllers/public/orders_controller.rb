class Public::OrdersController < ApplicationController
  def new
    @order=Order.new
    @orders=Order.all
  end
  def confirm
    @order = Order.new(order_params)
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
    @cart_items=current_customer.cart_items.all
    @total = 0
    @order.postage = 800
  end
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart_item.item.id
      @order_detail.order_id = @order.id
      @order_detail.quantity = cart_item.amount
      price = cart_item.item.with_tax_price
      @order_detail.purchase_amount = price
      @order_detail.save
    end
    current_customer.cart_items.destroy_all
    redirect_to orders_completion_path
  end
  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
  end


  def completion
  end
  private
  def order_params
    params.require(:order).permit(:payment_amount, :postal_code, :address, :name, :method_of_payment, :postage)
  end
end
