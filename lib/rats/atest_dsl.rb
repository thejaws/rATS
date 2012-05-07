module Atest
  def say(msg)
    msg = "[#{Time.now}] #{msg}"
    puts msg
  end

  def setup(info, &block)
    @test_receipt.started
    say "Setup"
    yield
    say "Setup done"
  end

  def start(info, &block)
  end

  def test_step(info, &block)
    say ">Test step: #{info}"
    retval = yield
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

  def finish(info, &block)
    @test_receipt.finished(info)
    retval = yield
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
