require 'rails_helper'

RSpec.describe Event, type: :model do
  subject { Event.new }

  describe '#start_date=' do
    it 'parses a string into a Date' do
      subject.start_date = '2010-1-23'
      expect(subject.start_date).to be_a Date
      expect(subject.start_date).to eq Date.new(2010, 1, 23)
    end
  end

  describe '#end_date=' do
    it 'parses a string into a Date' do
      subject.end_date = '2010-1-23'
      expect(subject.end_date).to be_a Date
      expect(subject.end_date).to eq Date.new(2010, 1, 23)
    end
  end
end
