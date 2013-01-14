# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "assert_type/version"

Gem::Specification.new do |s|
  s.name        = "assert_type"
  s.version     = AssertType::VERSION
  s.authors     = ["Joel Plane"]
  s.email       = ["joel.plane@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{simple method to do type assertions}
  s.description = %q{A method for very basic nested type assertions}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end

