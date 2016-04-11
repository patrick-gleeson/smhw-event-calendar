class Event < ActiveRecord::Base
  def start_date=(string_value)
    write_attribute(:start_date, Event.parse_date_string(string_value))
  end

  def end_date=(string_value)
    write_attribute(:end_date, Event.parse_date_string(string_value))
  end

  def as_json(_options = nil)
    {
      start: start_date,
      end: (end_date + 1),
      title: description
    }
  end

  class << self
    def all_between(from_date, to_date)
      where('start_date <= ? AND end_date >= ?',
            parse_date_string(to_date),
            parse_date_string(from_date))
    end

    def parse_date_string(date_string)
      Date.strptime(date_string, '%F')
    end
  end
end
