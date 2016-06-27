require 'test_helper'

class UnitsControllerTest < ActionController::TestCase

  def setup
    @user = users(:diego)
  end

  test "should get index" do
    log_in_as(@user)
    get :index
    assert_response :success
  end

end
