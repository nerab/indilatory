require 'helper'

class TestTag < MiniTest::Unit::TestCase
  include Indilatory

  def test_tag_without_tasks
    tag_name = 'mall'
    mall = Tag.new(tag_name)
    assert_equal(tag_name, mall.name)
    assert_equal(0, mall.tasks.size)
  end

  def test_assign_tag
    get_cash = Task.new('Get cash from ATM')
    assert_equal(0, get_cash.tags.size)

    mall = Tag.new('mall')
    get_cash.tags << mall

    # make sure double assignment works correctly (does nothing in this case)
    mall.tasks << get_cash

    assert_equal(1, get_cash.tags.size)
    assert_equal(1, mall.tasks.size)
  end

  def test_remove_tag
    get_cash = Task.new('Get cash from ATM')
    mall = Tag.new('mall')
    mall.tasks << get_cash
    assert_equal(1, mall.tasks.size)
    assert_equal(1, get_cash.tags.size)

    mall.tasks.delete(get_cash)
    assert_equal(0, mall.tasks.size)
    assert_equal(0, get_cash.tags.size)
  end
end
