require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end


  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { name: 'user3', password: 'secret', password_confirmation: 'secret' }
    end

    assert_redirected_to home_index_url
  end

  test 'should show user' do
    get :show, id: 1
    assert_response :success
  end

end
