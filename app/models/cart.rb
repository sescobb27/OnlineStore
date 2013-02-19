class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  
  def add_product(product)
    @current_item = line_items.where(product_id: product.id).first
    if @current_item
      @current_item.quantity += 1
      @current_item.price += product.price
    else
      @current_item = line_items.build(product_id: product.id, price: product.price)
    end
    @current_item
  end
  
  def total_price
    line_items.to_a.sum do |item|
      #item.total_price
      item.price
    end
  end
  
  def decrement_line_item_quantity(line_item_id)
    @current_item = line_items.find(line_item_id)
    if @current_item.quantity > 1
      @current_item.quantity -= 1
    else
      @current_item.destroy
    end
    if line_items.empty?
      self.destroy
    end
    @current_item
  end
end
