module DateHelpers
  def display_format(date)
    date.strftime "%A #{date.day.ordinalize} %b"
  end

  def entry_format(date)
    date.strftime '%F'
  end

  def nearest_past_monday
    nearest_monday = Date.parse 'Monday'
    nearest_monday - (nearest_monday > Date.today ? 7 : 0)
  end

  def nearest_future_sunday
    nearest_sunday = Date.parse 'Sunday'
    nearest_sunday + (nearest_sunday >= Date.today ? 0 : 7)
  end

  def tuesday_this_week
    nearest_past_monday + 1
  end

  def wednesday_this_week
    nearest_past_monday + 2
  end
end
