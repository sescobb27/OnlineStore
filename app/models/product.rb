class Product < ActiveRecord::Base
  
  attr_accessible :description, :image_url, :price, :title
  
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  {:description => "Description", :image_url=>"Image", :price=>"Price", :title=>"title"}.each do |key,value|
    validates_presence_of key, :message => "You can't leave the #{value} field empty"
  end
  
  validates_uniqueness_of :title, :message => "This title has already been taken"
  validates_numericality_of :price, :greater_than => 0, :message => "Price must be greater than 0"
  validates_format_of :image_url, 
                      :with => /\w+\.(gif|jpg|png)/i, 
                      :message => "must be a URL for GIF, JPG or PNG image."
  validates_length_of :title, :minimum => 5, :too_short => "please enter at least 5 character"
  
  def ensure_not_referenced_by_any_line_item
    if line_items.count.zero?
      true
    else
      errors.add(:base, 'Line Items present')
      false
    end
  end
    
end
