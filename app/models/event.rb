class Event < ActiveRecord::Base
  validates_presence_of :start_date, :end_date, :description,
                        message: 'must be provided and must be valid'

  def as_json(_options = nil)
    {
      start: start_date,
      end: (end_date + 1),
      title: description
    }
  end

  def all_errors
    errors.full_messages.join('. ') + '.'
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
