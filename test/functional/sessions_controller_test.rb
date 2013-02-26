require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  
  setup do
    @user = users(:one)
  end
  
  test "should get create" do
    get :create, @user
    assert_redirected_to store_path
  end

  test "should get destroy" do
    get :destroy
    assert_redirected_to store_path
  end

end
