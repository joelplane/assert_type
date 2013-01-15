module AssertType
  class TypeValidator
    class << self

      # @param type_node [AssertType::TypeNode, Array<AssertType::TypeNode>]
      # @param value [Object]
      def valid? type_node, value
        if type_node.name == "_root"
          type_node.children.any? do |node|
            valid? node, value
          end
        else
          type_matches?(type_node.name, value) &&
          children_valid?(type_node, value)
        end
      end

      private

      def type_matches? type_name, value
        case type_name
          when "nil"
            value == nil
          when "true"
            value == true
          when "false"
            value == false
          else
            type_name == value.class.to_s
        end

      end

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
