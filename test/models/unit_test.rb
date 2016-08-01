require 'test_helper'

class UnitTest < ActiveSupport::TestCase

  def setup
    @unit = Unit.new(quantity:    1,
                     product_id:  1,
                     category_id: 1,
                     pattern_id:  1,
                     fabric_id:   1,
                     color_id:    1,
                     batch_id:    nil,
                     colors: [hue: '1', tone: '1', darkness: '1'])

    @units = Unit.new(quantity:    5,
                      product_id:  1,
                      category_id: 1,
                      pattern_id:  1,
                      fabric_id:   1,
                      color_id:    1,
                      batch_id:    1,
                      colors: [hue: '1', tone: '1', darkness: '1'])
end

  test 'should be valid' do
    assert @unit.valid?
    assert @units.valid?
  end

  test 'quantity should be present and valid' do
    @unit.quantity = nil
    assert_not @unit.valid?
    @unit.quantity = -1
    assert_not @unit.valid?
    @unit.quantity = 1.1
    assert_not @unit.valid?
    @unit.quantity = '0'
    assert_not @unit.valid?

    @units.quantity = nil
    assert_not @units.valid?
    @units.quantity = -1
    assert_not @units.valid?
    @units.quantity = 1.1
    assert_not @units.valid?
    @units.quantity = '0'
    assert_not @units.valid?
  end

  test 'color_id should be present' do
    @unit.color_id = nil
    assert_not @unit.valid?

    @units.color_id = nil
    assert_not @units.valid?
  end

  test 'fabric_id should be present' do
    @unit.fabric_id = nil
    assert_not @unit.valid?

    @units.fabric_id = nil
    assert_not @units.valid?
  end

  test 'pattern_id should be present' do
    @unit.pattern_id = nil
    assert_not @unit.valid?

    @units.pattern_id = nil
    assert_not @units.valid?
  end
end
