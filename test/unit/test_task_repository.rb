require 'helper'
require 'tempfile'

class TestTaskRepository < MiniTest::Unit::TestCase
  include Indilatory

  def setup
    @data_dir = Dir.mktmpdir
    @repo = TaskRepository.new(Dir.new(@data_dir))
  end

  def teardown
    FileUtils.rm_r(@data_dir) if @data_dir && Dir.exist?(@data_dir)
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
