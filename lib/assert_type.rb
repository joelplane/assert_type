require "assert_type/version"
require "assert_type/assertion_error"
require "assert_type/call_error"

module AssertType

  module AssertMethods
    def at_assert truth
      unless truth
        raise AssertionError, "Expected truthy but was #{truth.inspect}"
      end
    end

    def at_assert_equal expected, actual
      unless expected == actual
        raise AssertionError.new expected, actual, false
      end
    end

    def at_assert_type expected_type, value
      if expected_type.is_a? Class
        unless expected_type === value
          raise AssertionError.new expected_type, value, false
        end
      elsif expected_type.is_a? Array
        unless expected_type.any? {|t| t === value}
          types = expected_type.collect do |t|
            "<#{t}>"
          end.join(' or ')
          raise AssertionError.new types, value, true
        end
      else
        if (matches = expected_type.match /([a-zA-Z0-9]+)\<([a-zA-Z0-9]+)\>/)
          enumerable_type = matches[1]
          child_type = matches[2]
          e_type = Object.const_get(enumerable_type)
          c_type = Object.const_get(child_type)
          unless e_type === value
            raise AssertionError.new e_type, value, false
          end
          unless value.first.nil? || c_type === value.first
            raise AssertionError.new "#{e_type}<#{c_type}>", "#{e_type}<#{value.first.class}>", true
          end
        else
          raise CallError.new
        end
      end
    end
  end

end

#    # Left this for the client application to decide - to add to Object or use otherwise
#    class Object
#      include AssertType::AssertMethods
#    end
