module Indilatory
  class Project < Entity
    include DDD::Associations

    has_one :title, :goal
    has_many :tasks

    def initialize(title, goal = nil)
      super()
      @title, @goal = title, goal
    end
  end
end
