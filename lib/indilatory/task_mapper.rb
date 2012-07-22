module Indilatory
  #
  # Maps tasks from and to JSON streams
  #
  class TaskMapper < Mapper
    #
    # Creates a new Task from the passed JSON stream
    #
    def load(stream)
      json = MultiJson.load(stream, :symbolize_keys => true)
      Task.new(json[:title]).tap do |t|
        t.uuid = json[:uuid]
        t.project = repository(Project).find(json[:project]) if json[:project]
      end
    end

    #
    # Creates a JSON stream that represents the passed task
    #
    def dump(task)
      MultiJson.dump({}.tap do |h|
        h[:title]    = task.title
        h[:uuid]     = task.uuid
        h[:project]  = task.project.uuid if task.project
      end)
    end
  end
end
