require 'helper'

class TestTaskRepositoryLoad < RepositoryTestCase
  include Indilatory

  def setup
    @repo = TaskRepository.new(fixtures_dir(self.class.name.underscore))
  end

  def test_load
    assert_equal(1, @repo.size)

    task = @repo.first
    assert_equal('51ff0614-fffd-47e1-8563-4deaf3168cc9', task.uuid)
    assert_equal('Read DDD book', task.title)
  end
end
