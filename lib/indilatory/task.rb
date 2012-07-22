module Indilatory
  class Task < Entity
    include DDD::Associations

    has_one :title
    belongs_to :project
    has_and_belongs_to_many :tags

    def initialize(title, project = nil)
      super()
      @title = title
      self.project = project
    end
  end
end
