module AssertType
  class AssertionError < RuntimeError

    def initialize expected, actual
      @expected = expected.to_s
      @actual = actual.inspect
    end

    def message
      "assertion failed - expected #{@expected} but was #{@actual}"
    end

  end
end
