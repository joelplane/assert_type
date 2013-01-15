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
      error.message.should include %{expected <Fixnum> or <String> but was 1.1}
    }

  end

end
