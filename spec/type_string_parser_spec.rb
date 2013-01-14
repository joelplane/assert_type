require 'spec_helper'
require File.expand_path('../lib/assert_type/type_string_parser.rb', File.dirname(__FILE__))

module AssertType
  describe TypeStringParser do

    context "converts string to node tree" do

      it "example: Array" do
        node = TypeStringParser.parse("Array")
        node.name.should == "Array"
        node.children.length.should == 0
      end

      it "example: Array<Fixnum>" do
        node = TypeStringParser.parse("Array<Fixnum>")
        node.name.should == "Array"
        node.children.length.should == 1
        node.children.first.name.should == "Fixnum"
      end

      it "example: Array<Fixnum, String>" do
        node = TypeStringParser.parse("Array<Fixnum, String>")
        node.name.should == "Array"
        node.children.length.should == 2
        node.children[0].name.should == "Fixnum"
        node.children[1].name.should == "String"
      end

      it "example: Array<Array<Fixnum>, Array<String>>" do
        node = TypeStringParser.parse("Array<Array<Fixnum>, Array<String>>")
        node.name.should == "Array"
        node.children.length.should == 2
        node.children[0].name.should == "Array"
        node.children[1].name.should == "Array"
        node.children[0].children.length.should == 1
        node.children[0].children[0].name.should == "Fixnum"
        node.children[1].children.length.should == 1
        node.children[1].children[0].name.should == "String"
      end

    end

  end
end
