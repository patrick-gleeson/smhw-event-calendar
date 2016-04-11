require 'rails_helper'

RSpec.feature 'Event calendar', type: :feature do
  scenario 'I see all the days of this week', js: true do
    visit '/events'
    expect(page).to have_text(display_format(Date.today))
    expect(page).to have_text(display_format(nearest_past_monday))
    expect(page).to have_text(display_format(nearest_future_sunday))
  end

  scenario 'I create an event', js: true do
    visit '/events'
    click_link 'Create event'
    fill_in 'event_start_date', with: entry_format(tuesday_this_week)
    fill_in 'event_end_date', with: entry_format(wednesday_this_week)
    fill_in 'event_description', with: 'My super event'
    click_button 'Save'
    expect(page).to have_text('Event saved')

    pending 'verify that event displays on calendar'
    expect(page).to have_text('My super event')
  end
end
