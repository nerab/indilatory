require 'helper'

class TestEntity < MiniTest::Unit::TestCase
  include Indilatory

  def setup
    @entity = Entity.new
  end

  def test_uuid
    refute_empty(@entity.uuid)
    assert_match(/[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}/, @entity.uuid)
  end

  def test_equality
    clone = @entity.dup
    assert_equal(clone, @entity)
    assert(clone == @entity)
  end

  def test_identity
    refute_equal(Entity.new, @entity)
    refute(Entity.new == @entity)
  end
end
