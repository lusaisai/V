require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should login" do
    user = users(:one)
    post :create, name: user.name, password: 'secret'
    assert_redirected_to home_index_url
    assert_equal user.id, session[:user_id]
  end

  test 'should not login' do
    post :create, :name => 'fake', :password => 'wrong'
    assert_redirected_to login_url
  end

  test "should logout" do
    delete :destroy
    assert_redirected_to login_url
  end

end
