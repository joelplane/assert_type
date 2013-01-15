require 'spec_helper'

include AssertType::AssertMethods

describe AssertType do

  it "quick and nasty tests" do

    at_assert_type Array, []
    at_assert_type "Array", []
    at_assert_type "Array", [1,2,3]
    at_assert_type "Array<Fixnum>", [1,2,3]
    at_assert_type "Array<Fixnum>", []
    expect { at_assert_type "Array<Fixnum>", ["one", "two", "three"] }.to raise_error(AssertType::AssertionError) { |error|
      error.message.should include %{expected Array<Fixnum> but was}
    }
    at_assert_type [Fixnum, String], 1
    at_assert_type [Fixnum, String], "1"
    expect { at_assert_type [Fixnum, String], 1.1 }.to raise_error(AssertType::AssertionError) { |error|
      error.message.should include %{expected Fixnum or String but was 1.1}
    }
    at_assert_type "Array<Fixnum>, nil", [1,2,3]
    at_assert_type "Array<Fixnum>, nil", []
    at_assert_type "Array<Fixnum>, nil", nil
    at_assert_type "String, Symbol", "hello"
    expect { at_assert_type "Array<Fixnum>, nil", false }.to raise_error(AssertType::AssertionError)
    expect { at_assert_type "Array<Fixnum>, nil", [nil] }.to raise_error(AssertType::AssertionError)

    at_assert_type "String, Symbol", "hello"
    at_assert_type "String, Symbol", :Symbol
    expect { at_assert_type "String, Symbol", 42 }.to raise_error(AssertType::AssertionError)

  end

end
