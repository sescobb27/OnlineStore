require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  
  fixtures :products
  
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end
  
  test "product price must be greater than 0" do
    product = Product.new(:title => "Book test", 
                    :description => "Book description",
                    :image_url => "www.jpg",
                    :price => 0)
    assert product.invalid?
    assert product.errors[:price].any?
    assert_equal "Price must be greater than 0",product.errors[:price].join(' ')
    
    product.price = -1
    assert product.invalid?
    assert product.errors[:price].any?
    assert_equal "Price must be greater than 0",product.errors[:price].join(' ')
    
    product.price = 1
    assert product.valid?
    
  end

  def new_product(image_url)
    Product.new(:title => "xxxxxx",
    :description => "xxxxxx",
    :price => "88",
    :image_url => image_url)
  end
  
  test "product image must has correct format" do
    product = Product.new(:title => "Book test", 
                    :description => "Book description",
                    :image_url => ".jpg",
                    :price => 30)
    assert product.invalid?
    assert product.errors[:image_url].any?
    
    good_img_url = %w{a-s.jpg xxxxxx.gif xxxxxx.png 2.gif xxx_xxx.jpg _xxx.png xxx_.gif}
    bad_img_url = %w{xxx.doc xxx xxx.gf xxx.pg xxx.jg xxx. .gif .png .jpg xxxgif xxxpng xxxjpg .gif.png}
    good_img_url.each { |name| assert new_product(name).valid?,"should be valid" }
    bad_img_url.each { |name| assert new_product(name).invalid?,"#{name} shouldn't be valid"}
  end

  test "product title must be unique" do
    product = Product.new(:title => products(:ruby).title, 
                    :description => "Book description",
                    :image_url => "sa.jpg",
                    :price => 30)
    assert !product.save
    assert_equal "This title has already been taken", product.errors[:title].join(' ')
  end
  
  test "product's title size must be greater than 5 characters" do
    product = Product.new(:title => "Ruby's book", 
                    :description => "Book description",
                    :image_url => "ad.jpg",
                    :price => 30)
    assert product.save
    product = products(:bad_titel)
    assert !product.save
  end
end
