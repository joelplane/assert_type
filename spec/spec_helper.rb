require 'rubygems'
require 'bundler/setup'

require File.expand_path("../lib/assert_type.rb", File.dirname(__FILE__))

RSpec.configure do |config|
end

class AssertType::TestClass; end
class AssertType::TestSubClass < AssertType::TestClass; end
class AssertType::TestSubSubClass < AssertType::TestSubClass; end
