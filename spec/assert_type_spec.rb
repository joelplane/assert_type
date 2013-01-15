require 'spec_helper'

include AssertType::AssertMethods

describe AssertType do

  def self.example_valid expected_type, value
    it "should not raise when asserting #{value.inspect} is a #{expected_type}" do
      at_assert_type expected_type, value
    end
  end

  def self.example_invalid expected_type, value
    it "should raise when asserting #{value.inspect} is a #{expected_type}" do
      expect { at_assert_type expected_type, value }.to raise_error(AssertType::AssertionError)
    end
  end

  example_valid   Array, []
  example_valid   "Array", []
  example_valid   "Array", [1,2,3]

  example_valid   "Array<Fixnum>", [1,2,3]
  example_valid   "Array<Fixnum>", []
  example_invalid "Array<Fixnum>", ["one", "two", "three"]

  example_valid   [Fixnum, String], 1
  example_valid   [Fixnum, String], "1"
  example_invalid [Fixnum, String], 1.1

  example_valid   "Array<Fixnum>, nil", [1,2,3]
  example_valid   "Array<Fixnum>, nil", []
  example_valid   "Array<Fixnum>, nil", nil
  example_invalid "Array<Fixnum>, nil", false
  example_invalid "Array<Fixnum>, nil", [nil]

  example_valid   "String, Symbol", "hello"
  example_valid   "String, Symbol", :Symbol
  example_invalid "String, Symbol", 42

end
