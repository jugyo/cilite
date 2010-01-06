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
      test_build_stub = Object.new
      mock(test_build_stub).start
      stub(test_build_stub).to_hash { {:foo => :bar} }
      stub(test_build_stub).status { 0 }
      stub(test_build_stub).output { 'output' }
      stub(test_build_stub).success? { true }
      mock(CiLite::Build).new(@runner.config[:test_command]) { test_build_stub }
      mock(CiLite::Log).[]=.with_any_args
      stub(Time).now { 'now' }

      $stdout = StringIO.new
      @runner.test('XXXX')
      $stdout = STDOUT
    end
  end
end
