require 'helper'

class TestTask < MiniTest::Unit::TestCase
  include Indilatory

  def test_task_without_project
    task_title = 'Buy milk'
    buy_milk = Task.new(task_title)

    assert_equal(task_title, buy_milk.title)
    assert_nil(buy_milk.project)
  end

  def test_init_with_project
    cake = Project.new('Birthday Cake')
    buy_milk = Task.new('Buy milk', cake)
    refute_nil(buy_milk.project)
    assert_equal(cake, buy_milk.project)
  end

  def test_assign_project
    buy_milk = Task.new('Buy milk')
    cake = Project.new('Birthday Cake')
    buy_milk.project = cake

    assert_equal(cake, buy_milk.project)
    assert_equal(1, buy_milk.project.tasks.size)
    assert_equal(1, buy_milk.project.tasks.first.project.tasks.first.project.tasks.size)
   end

  def test_deassign_project
    cake = Project.new('Birthday Cake')
    buy_milk = Task.new('Buy milk', cake)

    refute_nil(buy_milk.project)
    assert_equal(cake, buy_milk.project)
    assert_equal(1, buy_milk.project.tasks.size)
    assert_equal(1, cake.tasks.size)

    buy_milk.project = nil

    assert_nil(buy_milk.project)
    assert_equal(0, cake.tasks.size)
  end

  def test_enumerable_traits
    # This is what we are trying to do, overall.
    cake = Project.new('Birthday Cake')
    cake.goal = "Make a nice birthday cake for my son's 5th birthday"

    # No buying ingredients without money
    get_cash = Task.new('Get cash from ATM', cake)

    # We need milk, but can only buy it if we have some money in our hands
    buy_milk = Task.new('Buy milk', cake)
    # TODO buy_milk.dependencies << get_cash

    # Need to have all ingredients before we can start to bake
    bake_cake = Task.new('Bake cake', cake)
    # TODO bake_cake.dependencies << buy_milk

    assert_equal(3, cake.tasks.size)
    assert(cake.tasks.all?{|t| t.project == cake}, "Task does not belong to project '#{cake.title}'")
    assert(cake.tasks.any?{|t| t.title =~ /milk/}, "Could not find at least one task containing the word 'milk'")
    assert_equal(2, cake.tasks.chunk{|t| t.title.start_with?('B')}.count, "Task titles starting with 'B'")
    assert_equal('Mke', cake.tasks.collect{|t| t.title[-1]}.join, 'Collection of last character of task titles')
    assert_equal(cake.tasks.size, cake.tasks.count)

    title_chars = ''
    cake.tasks.cycle(2){|t| title_chars << t.title[0]}
    assert_equal('GBBGBB', title_chars, 'Cycled first title characters')

    assert_equal(get_cash, cake.tasks.find{|t| t.title == 'Get cash from ATM'}, "Could not find task with title 'Get cash from ATM'")
    assert_equal(1, cake.tasks.drop(2).size, 'Dropping two tasks must leave one remaining')
    assert_equal(2, cake.tasks.find_all{|t| t.title.start_with?('B')}.size, "Size of tasks which titles start with 'B'")

    groups = cake.tasks.group_by{|t| t.title[0]}
    assert_equal(1, groups['G'].size)
    assert_equal(2, groups['B'].size)

    assert(cake.tasks.include?(buy_milk), "Contains '#{buy_milk.title}'")
    refute(cake.tasks.include?(Task.new('Get cash from ATM')), "Does not contain new task")
    assert(cake.tasks.include?(Task.new('Put icing on the cake', cake)), "Contains task added on the fly")

    assert_equal(4, cake.tasks.size)

    assert_equal('Get cash from ATM, Buy milk, Bake cake, Put icing on the cake, ', cake.tasks.reduce(''){|arr, t| arr << t.title << ', '})
    assert_equal(['Get cash from ATM', 'Buy milk', 'Bake cake', 'Put icing on the cake'], cake.tasks.map{|t| t.title})
    assert_equal(cake.tasks.to_a.last, cake.tasks.max{|a,b| a.title.length <=> b.title.length})
    assert_equal(buy_milk, cake.tasks.min{|a,b| a.title.length <=> b.title.length})
    assert_equal([buy_milk, cake.tasks.to_a.last], cake.tasks.minmax{|a,b| a.title.length <=> b.title.length})
    assert(cake.tasks.none?{|t| t.project.nil?}, "Task without project '#{cake.title}'")
    assert(cake.tasks.one?{|t| t.title.length == 21}, "Exactly one task whith a title 21 chars long")
    assert_equal(1, cake.tasks.partition{|t| t.title.end_with?('M')}.first.size, "Partition on task titles ending with 'M'")
    assert_equal(2, cake.tasks.partition{|t| t.title.start_with?('B')}.last.size, "Partition on task titles starting with 'B'")
    assert_equal(2, cake.tasks.reject{|t| t.title.end_with?('cake')}.size, "Reject tasks with titles ending with 'cake'")
    assert_equal(bake_cake, cake.tasks.sort{|a,b| a.title <=> b.title}.first, 'First task if sorted by task title')

    assert_equal(2, cake.tasks.take(2).size)
    assert_equal(4, cake.tasks.size)
    assert_equal(4, cake.tasks.take_while{|t| t.project == cake}.size, "All tasks until one is not part of the 'cake' project")
  end
end
