require "assert_type/version"
require "assert_type/assertion_error"
require "assert_type/type_assertion_error"
require "assert_type/call_error"
require "assert_type/parse_error"
require "assert_type/type_string_parser"
require "assert_type/type_validator"

module AssertType

  module AssertMethods

    # @param expected_type [String] type string like "Array<Fixnum>"
    # @param value [Object] value to check against type string
    # @return [void]
    # @raise [AssertType::AssertionError, AssertType::ParseError, AssertType::CallError]
    def assert_type expected_type, value
      if expected_type.is_a? String
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

    def assert_type *args
    end

  end

end

#    # Left this for the client application to decide - to add to Object or use otherwise
#    class Object
#      include AssertType::AssertMethods
#    end
