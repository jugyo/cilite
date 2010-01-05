require 'helper'
require 'fakefs'

class TestLog < Test::Unit::TestCase
  context 'main' do
    setup do
      KVS.dir = 'foo'
    end

    should 'save log' do
      Tester::Log['test1'] = {:foo => :bar}
      assert_equal(['test1'], Tester::Log.logs)
      assert_equal({:foo => :bar}, Tester::Log['test1'])
      Tester::Log['test2'] = {:FOO => :BAR}
      assert_equal(['test1', 'test2'], Tester::Log.logs)
      assert_equal({:FOO => :BAR}, Tester::Log['test2'])
    end
  end
end
