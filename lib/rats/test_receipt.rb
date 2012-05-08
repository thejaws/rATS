class TestReceipt
  attr_reader :status
  def initialize(title)
    @title = title
    @check_points = {}
    @status = :created
    @result = :not_started
  end

  def started
    @start_time = Time.now
    @status = :started
    @result = :ok
  end

  def summary
    noof_cps = 0
    noof_nok = 0
    @check_points.keys.each do |cp_key|
      noof_cps += 1
      noof_nok += 1 unless [true, :ok].include? @check_points[cp_key]
    end

    sum = if noof_nok == 0
            "Test passed"
          else
            "Test failed"
          end
    puts "Test started     : #{@start_time}"
    puts "Test finished    : #{@finish_time}"
    puts "Test duration    : #{@finish_time - @start_time}"
    puts "Check point total: #{noof_cps}"
    puts "Check point fail : #{noof_nok}"
    puts "Test result      : #{sum}"
  end
  def finished(info)
    @finish_time = Time.now
    @status = :finished
    summary
  end

  def check_point(info, retval)
    @check_points[info] = retval
    if [false].include? retval
      @result = :not_ok
    end
  end

end

