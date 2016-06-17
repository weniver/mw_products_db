require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:diego)
    @user = users(:ivonne)
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", login_path, count: 2
    assert_select "a[href=?]", 'https://www.facebook.com/mamawolfmx/?fref=ts'
    log_in_as(@user)
    get root_path
    assert_select "a[href=?]", root_path, count: 1
    assert_select "a[href=?]", users_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 1
    assert_select "a[href=?]", logout_path, count: 1
    assert_select "a[href=?]", edit_user_path(@user), count: 1
    log_in_as(@admin)
    get root_path
    assert_select "a[href=?]", users_path, count: 1
    assert_select "a[href=?]", signup_path, count: 1
  end
end
