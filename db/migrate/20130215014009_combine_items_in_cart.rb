class CombineItemsInCart < ActiveRecord::Migration
  def up
    # replace multiple items for a single product in a cart with a single item
    Cart.all.each do |cart|
      # count the number of each product in the cart
      sums = cart.line_items.group(:product_id).sum(:quantity)
      #create a sums hash with products grouped by id and a sum of all his quantities
      sums.each do |product_id, quantity|
        if quantity > 1
          # remove individual items
          cart.line_items.where(:product_id=>product_id).delete_all
          # replace with a single item
          cart.line_items.create(:product_id=>product_id, :quantity=>quantity)
        end
      end
    end
  end
  
  def down
    # split items with quantity>1 into multiple items
    LineItem.where("quantity>1" ).each do |lineitem|
      # add individual items
      lineitem.quantity.times do
        endLineItem.create :cart_id=>lineitem.cart_id,
                           :product_id=>lineitem.product_id, :quantity=>1
      end
      # remove original item
      lineitem.destroy
    end
  end
end