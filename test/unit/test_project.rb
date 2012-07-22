require 'helper'

class TestProject < MiniTest::Unit::TestCase
  include Indilatory

  def test_project_without_tasks
    project_title = 'Birthday Cake'
    cake = Project.new(project_title)
    assert_equal(project_title, cake.title)
    assert(cake.tasks)
    assert_equal(0, cake.tasks.size)
  end

  def test_project_with_tasks
    project_title = 'Birthday Cake'
    cake = Project.new(project_title)

    cake.tasks << Task.new('Buy milk')
    assert_equal(1, cake.tasks.size)

    cake.tasks << Task.new('Buy flower')
    assert_equal(2, cake.tasks.size)

    # recursive access
    assert_equal(2, cake.tasks.first.project.tasks.size)

    # let's go over board
    assert_equal(2, cake.tasks.first.project.tasks.first.project.tasks.size)

    # enumerate tasks
    tasks_visited = 0

    cake.tasks.each do |task|
      assert_equal(cake, task.project)
      tasks_visited += 1
    end

    assert_equal(cake.tasks.size, tasks_visited)
  end

  def test_deassign_project
    cake = Project.new('Birthday Cake')
    buy_milk = Task.new('Buy milk', cake)

    refute_nil(buy_milk.project)
    assert_equal(cake, buy_milk.project)
    assert_equal(1, buy_milk.project.tasks.size)
    assert_equal(1, cake.tasks.size)

    # remove task from project
    cake.tasks.delete(buy_milk)

    # check the task and assert that the project is nil
    assert_nil(buy_milk.project)
    assert_equal(0, cake.tasks.size)
  end
end
