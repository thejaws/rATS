require File.join(File.dirname(__FILE__), '../spec_helper')

module Runtest
  describe AutomatedTest do
    context "Starting the test" do
      before(:each) do
        @test = AutomatedTest.new
      end

      it "should report that it's starting" do
        output = double('output')
        otest = AutomatedTest.new(output) 
        output.should_receive(:puts).with("Test started")

        otest.start_test
      end

      it "should report its test run id when asked to" do
        #test = AutomatedTest.new
        @test.test_id.class.should == 1.class
      end

      it "should have unique test run ids" do
        #test = AutomatedTest.new
        a = @test.test_id
        test2 = AutomatedTest.new
        b = test2.test_id

        b.should ==(a+1)
      end

      it "should  know its execution time" do 
        @test.start_test
        sleep(3)
        @test.end_test
        @test.duration.should >=(3)
       
      end
    end
  end
end
