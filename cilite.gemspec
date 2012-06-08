# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cilite/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["jugyo"]
  gem.email         = ["jugyo.org@gmail.com"]
  gem.description   = %q{CiLite is lite CI tool.}
  gem.summary       = %q{CiLite is lite CI tool for project that use git.}
  gem.homepage      = "http://github.com/jugyo/cilite"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "cilite"
  gem.require_paths = ["lib"]
  gem.version       = CiLite::VERSION
  gem.add_development_dependency "shoulda", ">= 0"
  gem.add_development_dependency "rr", ">= 0"
  gem.add_development_dependency "fakefs", ">= 0"
  gem.add_dependency 'ykk'
  gem.add_dependency 'sinatra'
  gem.add_dependency 'choice'
  gem.add_dependency 'termcolor', '>= 1.2.0'
end
