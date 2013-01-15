require 'spec_helper'
require File.expand_path('../lib/assert_type/type_string_parser.rb', File.dirname(__FILE__))

module AssertType
  describe TypeStringParser do

    context "converts string to node tree" do

      it "example: Array" do
        root = TypeStringParser.parse("Array")
        root.first.name.should == "Array"
        root.first.children.length.should == 0
      end

      it "example: Array<Fixnum>" do
        root = TypeStringParser.parse("Array<Fixnum>")
        root.first.name.should == "Array"
        root.first.children.length.should == 1
        root.first.children.first.name.should == "Fixnum"
      end

      it "example: Array<Fixnum, String>" do
        root = TypeStringParser.parse("Array<Fixnum, String>")
        root.first.name.should == "Array"
        root.first.children.length.should == 2
        root.first.children[0].name.should == "Fixnum"
        root.first.children[1].name.should == "String"
      end

      it "example: Array<Array<Fixnum>, Array<String>>" do
        root = TypeStringParser.parse("Array<Array<Fixnum>, Array<String>>")
        root.first.name.should == "Array"
        root.first.children.length.should == 2
        root.first.children[0].name.should == "Array"
        root.first.children[1].name.should == "Array"
        root.first.children[0].children.length.should == 1
        root.first.children[0].children[0].name.should == "Fixnum"
        root.first.children[1].children.length.should == 1
        root.first.children[1].children[0].name.should == "String"
      end

      it "example: Array<Fixnum>, nil" do
        root = TypeStringParser.parse("Array<Fixnum>, nil")
        root.children.length.should == 2
        root.children[0].name.should == "Array"
        root.children[0].children.length.should == 1
        root.children[0].children.first.name.should == "Fixnum"
        root.children[1].name.should == "nil"
        root.children[1].children.length.should == 0
      end

    end

  end
end
