
module TimeNow # mix-in

  module_function

  def time_now(now = Time.now)
    [now.year, now.month, now.day, now.hour, now.min, now.sec, now.usec]
  end

end
