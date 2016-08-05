require 'test_helper'

class StoreTest < ActiveSupport::TestCase
  def setup
    @store = Store.new(name:    "La Tienda",
                       address:  "La Calle donde esta la Tienda",
                       rfc: "VECJ880326XXX",
                       phone:  '1123-12321',
                       email: 'foo@bar.baz')
  end

  test 'should be valid' do
    assert @store.valid?
  end

  test 'name should be present' do
    @store.name = '  '
    assert_not @store.valid?
  end

  test 'rfc should be valid' do
    @store.rfc = '123J880326XXX'
    assert_not @store.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @store.email = valid_address
      assert @store.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @store.email = invalid_address
      assert_not @store.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
end
