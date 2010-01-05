$:.unshift(File.dirname(__FILE__) + "/../lib")
require 'tester'
run Tester::Server
