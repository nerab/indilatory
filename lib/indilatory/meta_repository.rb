module Indilatory
  #
  # Provides access to all repositories
  #
  class MetaRepository
    attr_reader :dir

    def initialize(dir)
      @dir = dir
    end

    def repository(entity_class)
      repository_class(entity_class).new(self)
    end

    protected

    def repository_class(entity_class)
      "#{entity_class}Repository".constantize
    end
  end
end
