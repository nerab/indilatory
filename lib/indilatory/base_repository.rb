module Indilatory
  #
  # Stores entities in directories named by entity as JSON files with the UUID
  # as file name. Kind of like a poor man's CouchDB.
  #
  # This class is intended to be subclassed and not used directly.
  #
  class BaseRepository
    include Enumerable
    extend Forwardable
    def_delegators :all, :each, :size

    def initialize(root_repo)
      @root_repo = root_repo
      Dir.mkdir(entity_dir) unless Dir.exist?(entity_dir)
    end

    def all
      Dir[location].map{|entity_file| mapper.load(File.read(entity_file))}
    end

    def save(entity)
      File.open(location(entity.uuid), 'w'){|f| f.write(mapper.dump(entity))}
    end

    protected

    #
    # Derived classes *must* override this method and specify what concrete
    # Entity class they are working on so that the correct Mapper class can be
    # derived.
    #
    # For instance, if this method returns Task, a mapper called TaskMapper
    # would be used to map Task objects back and forth.
    #
    def entity
      raise "No entity class defined for #{self.class}"
    end

    #
    # Derived classes *may* override this method and specify what Mapper class
    # is used to map objects from and to an IO object.
    #
    def mapper
      "#{entity}Mapper".constantize.new(@root_repo)
    end

    private

    def entity_dir
      File.join(@root_repo.dir.path, entity.name.demodulize.downcase.pluralize)
    end

    def location(file = '*')
      File.join(entity_dir, "#{file}.json")
    end
  end
end
