require 'helper'
require 'tmpdir'

class TestTestProcess < Test::Unit::TestCase
  context 'main' do
    setup do
      @test = Tester::TestProcess.new('foo')
    end

    should 'pass the test' do
      stub(@test).command {'ls'}
      @test.start
      assert_equal(0, @test.status)
      assert_equal(`ls 2>&1`, @test.output)
    end

    should 'not pass the test' do
      stub(@test).command {'ls foo'}
      @test.start
      assert_not_equal(0, @test.status)
      assert_equal(`ls foo 2>&1`, @test.output)
    end
  end
end
