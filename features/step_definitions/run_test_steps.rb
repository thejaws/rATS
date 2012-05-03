require 'rats'
Given  /^I have created a test$/ do
  @test = AutomatedTest.new
end

When /^the test runs$/ do
  @test.start_test
end


