class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :product_id, :order_id, :quantity, :price, :product, :cart, :order
  belongs_to :product
  belongs_to :cart
  belongs_to :order
  
  #def total_price
  #  price
  #end
end
