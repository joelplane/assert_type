module AssertType
  class AssertionError < RuntimeError

    def initialize expected, actual, expected_is_nested_type
      @expected = expected_is_nested_type ? expected.to_s : expected.inspect
      @actual = expected_is_nested_type ? actual.to_s : actual.inspect
    end

    def message
      "assertion failed - expected #{@expected} but was #{@actual}"
    end

  end
end
