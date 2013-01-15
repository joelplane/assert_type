require "assert_type/version"
require "assert_type/assertion_error"
require "assert_type/type_assertion_error"
require "assert_type/call_error"
require "assert_type/parse_error"
require "assert_type/type_string_parser"
require "assert_type/type_validator"

module AssertType

  module AssertMethods
    def at_assert truth
      unless truth
        raise AssertionError, "Expected truthy but was #{truth.inspect}"
      end
    end

    def at_assert_equal expected, actual
      unless expected == actual
        raise AssertionError.new expected, actual
      end
    end

    def at_assert_type expected_type, value
      if expected_type.is_a? Class
        unless expected_type === value
          raise TypeAssertionError.new expected_type.to_s, value
        end
      elsif expected_type.is_a? Array
        unless expected_type.any? {|t| t === value}
          types = expected_type.join(' or ')
          raise TypeAssertionError.new types, value
        end
      elsif expected_type.is_a? String
        if node = AssertType::TypeStringParser.parse(expected_type)
          unless AssertType::TypeValidator.valid?(node, value)
            raise TypeAssertionError.new expected_type, value
          end
        else
          raise ParseError.new
        end
      else
        raise CallError.new
      end
    end
  end

  module NoOpMethods
    def at_assert *args
    end

    def at_assert_equal *args
    end

    def at_assert_type *args
    end
  end

end

#    # Left this for the client application to decide - to add to Object or use otherwise
#    class Object
#      include AssertType::AssertMethods
#    end
