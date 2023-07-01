class Admin::CustomersController < ApplicationController
def index
  @customer=Customer.all
end
def show
  @customer = Customer.new
  @customer = Customer.find(params[:id])
end
def edit
  @customer = Customer.find(params[:id])
end
def update
  @customer=Customer.find(params[:id])
  @customer.update(customer_params)
  redirect_to admin_customer_path(@customer)
end
private
  def customer_params
    params.require(:customer).permit(:last_name, :id, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :is_deleted)
  end
end
