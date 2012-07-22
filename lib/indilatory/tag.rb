module Indilatory
  class Tag < Entity
    include DDD::Associations

    has_one :name
    has_many :tasks
    has_and_belongs_to_many :tasks

    def initialize(name)
      super()
      @name = name
    end
  end
end
