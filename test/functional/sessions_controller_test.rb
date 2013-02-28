require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  
  test "should get create" do
    user = users(:one)
    post :create, user: {name: user.name, password: "vpmSFP41:"}
    assert_equal user.id, session[:user_id]
    assert_redirected_to store_url
  end

  test "should get destroy" do
    get :destroy
    assert_redirected_to store_path
  end

end
