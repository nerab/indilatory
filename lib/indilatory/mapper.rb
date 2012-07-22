module Indilatory
  #
  # Base class for mappers that map from and to JSON streams
  #
  class Mapper
    def initialize(repositories)
      @repositories = repositories
    end

    protected

    attr_reader :repositories
  end
end
