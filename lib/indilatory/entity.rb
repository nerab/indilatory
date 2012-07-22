module Indilatory
  #
  # Base class for our domain entities. Note that this class does not have to
  # derive from any other base class just because we want to have associations.
  #
  class Entity
    attr_accessor :uuid

    def initialize
      @uuid = %x[uuidgen].strip.downcase # http://www.ruby-forum.com/topic/164078#722181
    end

    def hash
      uuid.hash
    end

    #
    # Identity comparison
    #
    # Entity objects have their identity defined by the uuid.
    # If the uuids are the same, the objects are identical.
    #
    def ==(other)
      return false unless other.is_a?(Entity)
      uuid == other.uuid
    end

    #
    # Equality comparison
    #
    # In contrast to identity comparison, equality is defined as having _all_ attributes identical, not just the uuid
    #
    def eql?(other)
      self.class.attributes.all?{|attr| send(attr).eql?(other.send(attr))}
    end
  end
end
