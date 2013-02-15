require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select '.banner .links a', :minimum => 4
    assert_select 'h2' , 'Programming Ruby 1.9'
    assert_select '.price' , /\$[,\d]+\.\d\d/
    assert_select '.main .table .product', 3
  end

end
