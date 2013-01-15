require File.expand_path("./assertion_error.rb", File.dirname(__FILE__))

module AssertType
  class TypeAssertionError < AssertionError

    def message
      "assertion failed - expected #{@expected} but was #{@actual.inspect}"
    end

  end
end
