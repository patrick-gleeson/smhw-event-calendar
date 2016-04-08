require 'rails_helper'

RSpec.feature 'Event calendar', type: :feature do
  let(:nearest_past_monday) do
    nearest_monday = Date.parse 'Monday'
    nearest_monday - (nearest_monday > Date.today ? 7 : 0)
  end

  let(:nearest_future_sunday) do
    nearest_sunday = Date.parse 'Sunday'
    nearest_sunday + (nearest_sunday >= Date.today ? 0 : 7)
  end

  scenario 'I see all the days of this week', js: true do
    visit '/events'
    expect(page).to have_text(format_date(Date.today))
    expect(page).to have_text(format_date(nearest_past_monday))
    expect(page).to have_text(format_date(nearest_future_sunday))
  end
end
