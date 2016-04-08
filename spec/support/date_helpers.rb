module DateHelpers
  def format_date(date)
    date.strftime "%A #{date.day.ordinalize} %b"
  end
end
