require 'helper'
require 'fakefs'

class TestLog < Test::Unit::TestCase
  context 'main' do
    setup do
      YKK.dir = 'foo'
    end

    should 'save log' do
      CiLite::Log['test1'] = {:foo => :bar}
      assert_equal(['test1'], CiLite::Log.logs)
      assert_equal({:foo => :bar}, CiLite::Log['test1'])
      CiLite::Log['test2'] = {:FOO => :BAR}
      assert_equal(['test1', 'test2'], CiLite::Log.logs)
      assert_equal({:FOO => :BAR}, CiLite::Log['test2'])
    end
  end
end
