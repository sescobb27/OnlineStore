class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end
  
  private
  
  def is_cart_line_items_empty?
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to store_url, notice: "Your cart is empty"
      true
    else
      false
    end
  end
end
