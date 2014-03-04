require 'test_helper'

class AdminsControllerTest < ActionController::TestCase
  test "should get scan" do
    get :scan
    assert_response :success
  end

  test "should get clean" do
    get :clean
    assert_response :success
  end

end
