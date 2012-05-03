require File.join(File.dirname(__FILE__), '../spec_helper')

module Runtest
  describe AutomatedTest do
    context "Running the test" do
      before(:each) do
        @test = AutomatedTest.new
      end

      it "should report its test run id when asked to" do
        @test.test_id.class.should == 1.class
      end

    end

    context "Specifying the test" do
      before(:each) do
        @test = AutomatedTest.new
      end
      it "should be able to accept test definitions as command lines" do
        @test.script = %Q{ls /tmp}
        @test.script.should == "ls /tmp"
      end

      it "should be able to accept a ruby object as a test definition" do
        @test.test = Object.new
        @test.test.class.name.should == Object.name
      end

      it "should be able to accept a cucumber script as a test definition" do
        @test.cucumber = %Q{cucumber}
        @test.cucumber.should match(/^cucumber/)
      end
    end
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

      it "should have unique test run ids" do
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
