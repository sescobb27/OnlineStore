class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :name, null: false
      t.text :address, null: false
      t.string :email, null: false
      t.string :pay_type, null: false

      t.timestamps
    end
  end
end
