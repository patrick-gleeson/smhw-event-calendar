class Event < ActiveRecord::Base
  def start_date=(string_value)
    value = Date.strptime(string_value, '%F')
    write_attribute(:start_date, value)
  end

  def end_date=(string_value)
    value = Date.strptime(string_value, '%F')
    write_attribute(:end_date, value)
  end
end
