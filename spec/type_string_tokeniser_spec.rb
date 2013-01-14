require 'spec_helper'
require File.expand_path('../lib/assert_type/type_string_tokeniser.rb', File.dirname(__FILE__))

module AssertType
  describe TypeStringTokeniser do

    it "converts string to array of tokens" do

      TypeStringTokeniser.tokenise("Array<Fixnum>").collect{|t|[t.name,t.value]}.should == [
        [:word, "Array"], [:open_angle, "<"], [:word, "Fixnum"], [:close_angle, ">"]
      ]

      TypeStringTokeniser.tokenise("Array<Fixnum, String>").collect{|t|[t.name,t.value]}.should == [
        [:word, "Array"], [:open_angle, "<"], [:word, "Fixnum"], [:comma, ","], [:word, "String"], [:close_angle, ">"]
      ]

    end

  end
end
