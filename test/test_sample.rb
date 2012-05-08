$: << 'lib'
$: << File.dirname(__FILE__)

require 'rats'
require 'selenium-webdriver'
require 'system_under_test'


class SmokeTest
  include Atest 

  def initialize(title)
    @test_receipt = TestReceipt.new(title)
    @indent_level = 0
  end 

  def create_sut
    @sut = SystemUnderTest.new
  end

  def test_addition
    check_point("Add two numbers:"){1+2 == @sut.add(1,2)}
    check_point("Addition order doesn't matter"){@sut.add(31,1) == @sut.add(1,31)}
    check_point("This one should fail") do
      @sut.add(31,1) == @sut.add(31,2)
    end
  end

  def test_subtraction
    check_point("Subtract two numbers"){@sut.sub(31,0) == 31}
  end

  def execute_test
    setup("Setting up")     {create_sut}
    test_step("Addition")   {test_addition}
    test_step("Subtraction"){test_subtraction}
    finish("Done")
  end
end

if __FILE__ == $0
  smoke = SmokeTest.new("A smoke")
  smoke.execute_test
end
