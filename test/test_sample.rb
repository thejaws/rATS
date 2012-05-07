$: << 'lib'
require 'rats'
require 'selenium-webdriver'

class TestReceipt
  def initialize(title)
    @title = title
    @check_points = {}
  end

  def started
    @start_time = Time.now
  end

  def finished
    @finish_time = Time.now
  end

  def check_point(info, retval)
    @check_points[info] = retval
  end
end

class SmokeTest
  include Atest 
  def initialize(title)
    @test_receipt = TestReceipt.new(title)
  end
  
  def create_browser
    @browser = Selenium::WebDriver.for :ff
  end

  def goto(url)
    @browser.navigate.to('http://tv.nrk.no')
    check_point("should go to #{url}"){@browser.current_url == 'http://tv.nrk.no'} 
  end

  def execute_test
    setup("Setting up"){create_browser}

    test_step("Goto tv.NRK.NO"){goto('http://tv.nrk.no')}
    test_step("Goto radio.NRK.NO"){goto('http://tv.nrk.no')}

    finish("Closing down browser") do
      @browser.quit
    end
  end
end

if __FILE__ == $0
  smoke = SmokeTest.new("A smoke")
  smoke.execute_test
end
