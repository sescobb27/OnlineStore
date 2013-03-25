class AddAttachmentImgToProducts < ActiveRecord::Migration
  def self.up
  	remove_column :products, :photo
    change_table :products do |t|
      t.attachment :img
    end
  end

  def self.down
    drop_attached_file :products, :img
    add_column :products, :photo
  end
end
