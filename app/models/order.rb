class Order < ActiveRecord::Base
  
  PAYMENT_TYPES = {check: "Check", credit_cart: "Credit card", purchase_order: "Purchase order"}
  
  validates_presence_of :address, :email, :name, :pay_type
  validates_inclusion_of :pay_type, in: PAYMENT_TYPES.values
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create
  
  attr_accessible :address, :email, :name, :pay_type
  
  has_many :line_items, dependent: :destroy
  
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
  
end
