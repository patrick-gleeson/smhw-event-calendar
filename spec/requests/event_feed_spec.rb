require 'rails_helper'

RSpec.describe 'Event feed', type: :request do
  it 'shows relevant events' do
    Event.create(start_date: 3.days.ago.strftime('%F'),
                 end_date: 2.days.ago.strftime('%F'),
                 description: 'My test event')

    get "/api/events?start=#{4.days.ago.strftime('%F')}" \
        "&end=#{1.day.ago.strftime('%F')}"

    expect(response.body).to include('My test event')
  end
end
