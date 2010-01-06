unless File.exists?('.git')
  puts 'not git dir'
  exit!
end

require 'kvs'
require 'singleton'
require 'sinatra'
gem 'termcolor', '>= 1.2.0'
require 'termcolor'

work_dir = '.cilite'
Dir.mkdir(work_dir) unless File.exists?(work_dir)
KVS.dir = work_dir

Dir[File.join(File.dirname(__FILE__), 'cilite', '*.rb')].each do |filename|
  require filename
end
