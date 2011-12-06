# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "springpad/version"

Gem::Specification.new do |s|
  s.name        = "springpad"
  s.version     = Springpad::VERSION
  s.authors     = ["Josep M. Bach"]
  s.email       = ["josep.m.bach@gmail.com"]
  s.homepage    = "http://github.com/txus/springpad"
  s.summary     = %q{Command-line client for Springpad.}
  s.description = %q{Command-line client for Springpad.}

  s.rubyforge_project = "springpad"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "minitest"
  s.add_development_dependency "mocha"
  s.add_development_dependency "vcr"
  s.add_development_dependency "webmock"
  s.add_runtime_dependency "rest-client"
end
