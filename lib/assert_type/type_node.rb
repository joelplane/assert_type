module AssertType
  class TypeNode

    attr_reader :name, :children

    def initialize name
      @name = name
      @children = []
    end

    def first
      @children.first
    end

    def self.root
      new "_root"
    end

  end
end
