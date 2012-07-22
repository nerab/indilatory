require 'helper'

class TestTaskRepository < RepositoryTestCase
  def setup
    super
    @repo = TaskRepository.new(Dir.new(repo_path))
  end

  def test_all_empty
    assert_equal(0, @repo.all.size)
  end

  def test_save_and_read_task
    read_ddd = Task.new('Read DDD book')
    @repo.save(read_ddd)
    assert_equal(1, @repo.count)

    read_back = @repo.first
    assert_equal(read_ddd, read_back)
    assert(read_ddd.eql?(read_back))
  end
end
