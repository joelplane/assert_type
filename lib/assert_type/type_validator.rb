module AssertType
  class TypeValidator
    class << self

      # @param type_node [AssertType::TypeNode]
      # @param value [Object]
      def valid? type_node, value
        type_node.name == value.class.to_s &&
        children_valid?(type_node, value)
      end

      private

      def children_valid? type_node, value
        type_node.children.empty? ||
        value_empty?(value) ||
        type_node.children.any? do |node|
          valid?(node, value_first_child(value))
        end
      end

      def value_first_child value
        value.first
      end

      def value_empty? value
        value.empty?
      end

    end
  end
end
