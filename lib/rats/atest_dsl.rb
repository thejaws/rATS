module Atest
  def say(msg)
    indent = " " * @indent_level
    msg = "[#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}]#{indent} #{msg}"
    puts msg
  end

  def setup(info, &block)
    @test_receipt.started
    say "Setup"
    retval = yield
    say "Setup done"
    return retval
  end

  def start(info, &block)
    say info
    retval = yield
    return retval
    say "Started"
  end

  def test_step(info, &block)
    say ">Test step: #{info}"
    @indent_level += 2
    retval = yield
    @indent_level -= 2
    say "=Test step: #{info}"
    return retval
  end

  def mandatory_test_step(info, &block)
  end

  def check_point(info, &block)
    say "? check: #{info}"
    retval = yield
    say "=check: [#{retval}] (#{info})"
    @test_receipt.check_point(info, retval)
    return retval
  end

  def finish(info)
    @test_receipt.finished(info)
    retval = yield if block_given?
    return retval
  end
end

if __FILE__ == $0
  include Atest
  setup("Setting up one thing") do |x|
    puts "This is the setup"
    :ok
  end
end
