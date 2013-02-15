class AddPriceToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :price, :decimal, precision: 8, scale: 3
    LineItem.all.each do |lineitem|
      lineitem.update_attributes price: lineitem.product.price * lineitem.quantity
    end
  end
end
