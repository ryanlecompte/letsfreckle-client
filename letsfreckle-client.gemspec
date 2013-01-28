# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "letsfreckle/version"

Gem::Specification.new do |s|
  s.name        = "letsfreckle-client"
  s.version     = Letsfreckle::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ryan LeCompte"]
  s.email       = ["lecompte@gmail.com"]
  s.homepage    = "http://github.com/ryanlecompte/letsfreckle-client"
  s.summary     = %q{Ruby client for letsfreckle.com API}
  s.description = %q{Ruby client for letsfreckle.com API that supports entries, projects, tags, and users}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'hashie', '~> 1.1.0'
  s.add_dependency 'faraday', '~> 0.7.4'
  s.add_dependency 'faraday_middleware', '~> 0.7.0'
  s.add_dependency 'multi_xml', '~> 0.2.0'
  s.add_development_dependency "activesupport", "~> 2.3"
  s.add_development_dependency 'rspec', '~> 2.5.0'
  s.add_development_dependency 'webmock', '~> 1.6.2'
end
