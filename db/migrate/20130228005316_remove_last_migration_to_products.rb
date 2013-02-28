class RemoveLastMigrationToProducts < ActiveRecord::Migration
  def up
  	add_column :products, :photo, :string
  	remove_column :products, :photo_file_name, :string
  	remove_column :products, :photo_content_type, :string
  	remove_column :products, :photo_content_size, :integer
  	remove_column :products, :photo_updated_at, :datetime
  end

  def down
  	remove_column :products, :photo, :string
  	add_column :products, :photo_file_name, :string
  	add_column :products, :photo_content_type, :string
  	add_column :products, :photo_content_size, :integer
  	add_column :products, :photo_updated_at, :datetime
  end
end
