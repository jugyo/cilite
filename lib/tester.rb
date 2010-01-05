unless File.exists?('.git')
  puts 'not git dir'
  exit!
end

require 'kvs'
require 'singleton'
require 'sinatra'

work_dir = '.tester'
Dir.mkdir(work_dir) unless File.exists?(work_dir)
KVS.dir = work_dir

Dir[File.join(File.dirname(__FILE__), 'tester', '*.rb')].each do |filename|
  require filename
end
