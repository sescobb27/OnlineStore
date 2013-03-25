class Product < ActiveRecord::Base
  
  attr_accessible :description, :price, :title,:img
  
  has_attached_file :img,
      :styles => { :thumb => "200x200>" },
      :url  => "/assets/users/:id/:style/:basename.:extension",
        :path => ":rails_root/public/assets/users/:id/:style/:basename.:extension"

  validates_attachment_presence :img
  validates_attachment_size :img, :less_than => 10.megabytes
  validates_attachment_content_type :img, :content_type => ['image/jpeg', 'image/png']
  
  has_many :line_items
  has_many :orders, through: :line_items 
  before_destroy :ensure_not_referenced_by_any_line_item

  {:description => "Description", :price=>"Price",
    :title=>"title"}.each do |key,value|
    validates_presence_of key,
        :message => "You can't leave the #{value} field empty"
  end
  
  validates_uniqueness_of :title,
       :message => "This title has already been taken"
  validates_numericality_of :price,
      :greater_than => 0, :message => "Price must be greater than 0"
  validates_length_of :title, :minimum => 5,
      :too_short => "please enter at least 5 character"
  
  def ensure_not_referenced_by_any_line_item
    if line_items.count.zero?
      true
    else
      errors.add(:base, 'Line Items present')
      false
    end
  end
    
end
