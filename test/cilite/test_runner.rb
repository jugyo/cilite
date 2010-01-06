require 'helper'

class TestRunner < Test::Unit::TestCase
  context 'main' do
    setup do
      @runner = CiLite::Runner.new({:branch => 'foo', :command => 'bar', :interval => 10})
    end

    should 'test if updated' do
      test_build_stub = Object.new
      mock(test_build_stub).start
      stub(test_build_stub).to_hash { {:foo => :bar} }
      stub(test_build_stub).status { 0 }
      stub(test_build_stub).output { 'output' }
      stub(test_build_stub).success? { true }
      mock(CiLite::Build).new(@runner.command) { test_build_stub }
      mock(CiLite::Log).[]=.with_any_args
      stub(Time).now { 'now' }

      $stdout = StringIO.new
      @runner.test('XXXX')
      $stdout = STDOUT
    end

    should 'not test if not updated' do
      KVS['foo'] = 'bar'
      stub(@runner).git_update { 'foo' }
      mock(@runner).test('foo').times(0)
      @runner.test_if_updated
    end
  end
end
