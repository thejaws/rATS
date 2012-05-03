require 'bundler/setup'
#
# AutomatedTest is the 'parent' class for all automated tests
# An AutomatedTest could be any shell script (the fail/succeed criterion)
# by default being whether the scripts exit status is zero (success) or non-zero (failure)
# In such a case, the output from the script will also be scrutinized to find out whether the test
# was a success.
#
class AutomatedTest
  attr_reader :test_id
  attr_reader :start_time, :finish_time

  # A :script is any command that provieds a proper exit status and 
  # meaningful output
  #
  # A :test is a ruby object that adheres to the requirements (TBD)
  #
  # A :cucumber is a cucumber script.
  attr_accessor :script, :test, :cucumber

  @@test_id = 0
  def initialize(output=$stdout)
    @test_id = get_test_id
    @out = output
  end

  def get_test_id
    @@test_id += 1
    @@test_id
  end

  def start_test
    @out.puts "Test started"
    @start_time = Time.now
    if defined? @script
      system @script
      end_test
    elsif defined? @test
    elsif defined? @cucumber
    end
  end

  def duration
    @finish_time - @start_time
  end

  def end_test
    @finish_time = Time.now
  end 
end
