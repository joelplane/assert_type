require File.expand_path("./error.rb", File.dirname(__FILE__))

module AssertType
  class AssertionError < Error

    attr_reader :expected, :actual

    def initialize expected, actual
      @expected = expected
      @actual = actual
    end

    def message
      "assertion failed - expected #{@expected} but was #{@actual}"
    end

  end
end
