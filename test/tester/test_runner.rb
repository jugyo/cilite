require 'helper'

class TestRunner < Test::Unit::TestCase
  context 'main' do
    setup do
      @runner = CiLite::Runner.new({:branch => 'foo', :test_command => 'bar', :interval => 10})
    end

    should 'Runner.new' do
      assert_equal(@runner.config[:branch], @runner.checker.branch)
    end

    should 'test if updated' do
      test_process_stub = Object.new
      mock(test_process_stub).start
      stub(test_process_stub).to_hash { {:foo => :bar} }
      stub(test_process_stub).status { 0 }
      stub(test_process_stub).output { 'output' }
      mock(CiLite::Process).new(@runner.config[:test_command]) { test_process_stub }
      mock(CiLite::Log).[]=.with_any_args
      stub(Time).now { 'now' }

      $stdout = StringIO.new
      @runner.test('XXXX')
      $stdout = STDOUT
    end
  end
end
