module AssertType
  class TypeNode

    attr_reader :name, :children

    def initialize name
      @name = name
      @children = []
    end

  end
end
