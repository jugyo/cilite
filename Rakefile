require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "cilite"
    gem.summary = %Q{CiLite is lite CI tool.}
    gem.description = %Q{CiLite is lite CI tool for project that use git.}
    gem.email = "jugyo.org@gmail.com"
    gem.homepage = "http://github.com/jugyo/cilite"
    gem.authors = ["jugyo"]
    gem.add_development_dependency "shoulda", ">= 0"
    gem.add_development_dependency "rr", ">= 0"
    gem.add_dependency 'ykk'
    gem.add_dependency 'sinatra'
    gem.add_dependency 'choice'
    gem.add_dependency 'termcolor', '>= 1.2.0'
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "cilite #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
