require 'spec_helper'
require File.expand_path('../lib/assert_type/type_validator.rb', File.dirname(__FILE__))

module AssertType
  describe TypeValidator do

    it "example: Array" do
      node = stub("TypeNode", :name => "Array", :children => [])
      TypeValidator.valid?(node, []).should be_true
      TypeValidator.valid?(node, [1,2,3]).should be_true
      TypeValidator.valid?(node, ["one","two","three"]).should be_true
      TypeValidator.valid?(node, {}).should be_false
    end

    it "example: Set" do
      node = stub("TypeNode", :name => "Set", :children => [])
      TypeValidator.valid?(node, Set.new).should be_true
      TypeValidator.valid?(node, Set.new([1,2,3])).should be_true
      TypeValidator.valid?(node, Set.new(["one","two","three"])).should be_true
      TypeValidator.valid?(node, []).should be_false
      TypeValidator.valid?(node, [1,2,3]).should be_false
      TypeValidator.valid?(node, ["one","two","three"]).should be_false
      TypeValidator.valid?(node, {}).should be_false
    end

    it "example: Hash" do
      node = stub("TypeNode", :name => "Hash", :children => [])
      TypeValidator.valid?(node, {}).should be_true
      TypeValidator.valid?(node, {:one => 1, :two => 2}).should be_true
      TypeValidator.valid?(node, []).should be_false
      TypeValidator.valid?(node, [1,2,3]).should be_false
      TypeValidator.valid?(node, ["one","two","three"]).should be_false
    end

    it "example: Array<Fixnum>" do
      node = stub("TypeNode", :name => "Array", :children => [
        stub("TypeNode", :name => "Fixnum", :children => [])
      ])
      TypeValidator.valid?(node, [1,2,3]).should be_true
      TypeValidator.valid?(node, []).should be_true
      TypeValidator.valid?(node, ["one", "two", "three"]).should be_false
    end

    it "example: Array<Fixnum, String>" do
      node = stub("TypeNode", :name => "Array", :children => [
        stub("TypeNode", :name => "Fixnum", :children => []),
        stub("TypeNode", :name => "String", :children => [])
      ])
      TypeValidator.valid?(node, [1,2,3]).should be_true
      TypeValidator.valid?(node, ["one", "two", "three"]).should be_true
      TypeValidator.valid?(node, []).should be_true
      TypeValidator.valid?(node, [1.1,2.2,3.3]).should be_false
    end

    it "example: Array<Array<Fixnum>>" do
      node = stub("TypeNode", :name => "Array", :children => [
        stub("TypeNode", :name => "Array", :children => [
          stub("TypeNode", :name => "Fixnum", :children => [])
        ])
      ])
      TypeValidator.valid?(node, [[1,2,3]]).should be_true
      TypeValidator.valid?(node, [[]]).should be_true
      TypeValidator.valid?(node, []).should be_true
      TypeValidator.valid?(node, [1,2,3]).should be_false
      TypeValidator.valid?(node, ["one", "two", "three"]).should be_false
      TypeValidator.valid?(node, [["one", "two", "three"]]).should be_false

    end

    it "example: Array<Set<Fixnum>>" do
      node = stub("TypeNode", :name => "Array", :children => [
        stub("TypeNode", :name => "Set", :children => [
          stub("TypeNode", :name => "Fixnum", :children => []),
        ])
      ])

      TypeValidator.valid?(node, [Set.new([1,2,3])]).should be_true
      TypeValidator.valid?(node, [Set.new]).should be_true
      TypeValidator.valid?(node, []).should be_true
      TypeValidator.valid?(node, [Set.new(["one", "two", "three"])]).should be_false
      TypeValidator.valid?(node, [{}]).should be_false
      TypeValidator.valid?(node, [[]]).should be_false
    end

    ## Note: we can't parse this yet
    #xit "example: Hash{Symbol => Fixnum}" do
    #  node = stub("TypeNode", :name => "Hash", :children => [
    #    stub("TypeNode", :name => "_params", :children => [
    #      stub("TypeNode", :name => "Symbol", :children => []),
    #      stub("TypeNode", :name => "Fixnum", :children => [])
    #    ])
    #  ])
    #  TypeValidator.valid?(node, {}).should be_true
    #  TypeValidator.valid?(node, {:one => 1, :two => 2}).should be_true
    #  TypeValidator.valid?(node, {:one => "1", :two => "2"}).should be_false
    #  TypeValidator.valid?(node, []).should be_false
    #  TypeValidator.valid?(node, [1,2,3]).should be_false
    #  TypeValidator.valid?(node, ["one","two","three"]).should be_false
    #end

  end
end
