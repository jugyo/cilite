require 'helper'
require 'fakefs'

class TestChecker < Test::Unit::TestCase
  context 'main' do
    setup do
      KVS.dir = 'foo'
      KVS['HEAD'] = ''
      @checker = Tester::Checker.new('master')
      stub(@checker).update
    end

    should 'check updated' do
      stub(@checker).head { 'foo' }
      block = lambda {}
      mock(block).call('foo')
      # NOTE: rr が思ったような動作をしてくれないのでこんな書き方になってます...
      @checker.if_updated do |hash|
        block.call(hash)
      end
      mock(block).call('foo').times(0)
      @checker.if_updated do |hash|
        block.call(hash)
      end
    end
  end
end
