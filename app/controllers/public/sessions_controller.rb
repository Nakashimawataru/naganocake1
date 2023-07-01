# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :customer_state, only: [:create]
  def after_sign_in_path_for(resource)
     customers_show_path
  end
  def after_sign_out_path_for(resource)
     root_path
  end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected
  def customer_state
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
    @customer=Customer.find_by(email:params[:customer][:email])
    return if !@customer
    if @customer.valid_password?(params[:customer][:password])
      if @customer.is_deleted?
        redirect_to root_path
      end
    end
  end
end

