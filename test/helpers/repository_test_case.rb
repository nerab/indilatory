require 'tempfile'

class RepositoryTestCase < MiniTest::Unit::TestCase
  include Indilatory

  def setup
    @repo_path = Dir.mktmpdir
  end

  def teardown
    FileUtils.rm_r(@repo_path) if @repo_path && Dir.exist?(@repo_path)
  end

  protected

  attr_reader :repo_path

  def fixtures_dir(name)
    Dir.new(File.join(File.dirname(__FILE__), '..', 'fixtures', name))
  end
end
