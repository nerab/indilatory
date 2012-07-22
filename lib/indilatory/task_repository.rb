module Indilatory
  class TaskRepository
    include Enumerable
    extend Forwardable
    def_delegators :all, :each

    def initialize(dir)
      @dir = dir
      Dir.mkdir(entity_dir) unless Dir.exist?(entity_dir)
    end

    def all
      Dir[location].map{|task_file| TaskMapper.load(File.read(task_file))}
    end

    def save(task)
      File.open(location(task.uuid), 'w'){|f| f.write(TaskMapper.dump(task))}
    end

    protected

    def entity_dir
      File.join(@dir.path, 'tasks')
    end

    def location(file = '*')
      File.join(entity_dir, "#{file}.json")
    end
  end
end
