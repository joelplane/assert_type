require 'spec_helper'

include AssertType::AssertMethods

describe AssertType do

  def self.example_valid expected_type, value
    it "should not raise when asserting #{value.inspect} is a #{expected_type}" do
      assert_type expected_type, value
    end
  end

  def self.example_invalid expected_type, value
    it "should raise assertion error when asserting #{value.inspect} is a #{expected_type}" do
      expect { assert_type expected_type, value }.to raise_error(AssertType::AssertionError)
    end
  end

  def self.example_call_error expected_type, value
    it "should raise call error when asserting #{value.inspect} is a #{expected_type}" do
      expect { assert_type expected_type, value }.to raise_error(AssertType::CallError)
    end
  end

  def self.example_parse_error expected_type, value
    it "should raise parse error when asserting #{value.inspect} is a #{expected_type}" do
      expect { assert_type expected_type, value }.to raise_error(AssertType::ParseError)
    end
  end

  example_valid   "Array", []
  example_valid   "Array", [1,2,3]

  example_valid   "Array<Fixnum>", [1,2,3]
  example_valid   "Array<Fixnum>", []
  example_invalid "Array<Fixnum>", ["one", "two", "three"]

  example_valid   "Array<Fixnum>, nil", [1,2,3]
  example_valid   "Array<Fixnum>, nil", []
  example_valid   "Array<Fixnum>, nil", nil
  example_invalid "Array<Fixnum>, nil", false
  example_invalid "Array<Fixnum>, nil", [nil]

  example_valid   "String, Symbol", "hello"
  example_valid   "String, Symbol", :Symbol
  example_invalid "String, Symbol", 42

  example_call_error Array, []
  example_call_error [Fixnum, String], 1
  example_call_error [1,2,3], "Array<Fixnum>"

  example_parse_error "Array<", []
  example_parse_error "Array<>", []
  example_parse_error "Array>", []
  example_parse_error "A{B => C}", []

end
