module Indilatory
  #
  # Maps tasks from and to JSON streams
  #
  class TaskMapper
    class << self
      #
      # Creates a new Task from the passed JSON stream
      #
      def load(stream)
        json = MultiJson.load(stream, :symbolize_keys => true)
        Task.new(json[:title]).tap do |t|
          t.uuid = json[:uuid]
        end
      end

      #
      # Creates a JSON stream that represents the passed task
      #
      def dump(task)
        MultiJson.dump({}.tap do |h|
          h[:title] = task.title
          h[:uuid]  = task.uuid
        end)
      end
    end
  end
end
