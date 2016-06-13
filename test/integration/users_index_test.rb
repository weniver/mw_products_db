require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:diego)
    @user = users(:ivonne)
  end

  test "index as an admin including pagination" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_users = User.paginate(page: 1)
    first_page_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete',
                                                    method: :delete
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
  end

  test "index as non-admin" do
    log_in_as(@user)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end