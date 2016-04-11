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

  describe '#as_json' do
    subject do
      Event.new(start_date: '2010-1-23',
                end_date: '2010-1-24',
                description: 'Some description')
           .as_json
    end

    it 'includes start_date as "start"' do
      expect(subject[:start]).to eq Date.new(2010, 1, 23)
    end

    it 'includes day after end_date as "end"' do
      expect(subject[:end]).to eq Date.new(2010, 1, 25)
    end

    it 'includes description as "title"' do
      expect(subject[:title]).to eq 'Some description'
    end
  end

  describe '.all_between' do
    it 'returns events that intersect with given range' do
      overlapping = [[5, 1], [3, 3], [5, 3], [3, 1]]
      overlapping.each do |range|
        event = Event.create(start_date: range[0].days.ago.strftime('%F'),
                             end_date: range[1].days.ago.strftime('%F'),
                             description: 'Foo')

        ret = Event.all_between(4.days.ago.strftime('%F'),
                                2.days.ago.strftime('%F'))
        expect(ret).to include(event)
      end
    end

    it 'omits events that do not intersect with given range' do
      missing = [[5, 5], [1, 1]]
      missing.each do |range|
        event = Event.create(start_date: range[0].days.ago.strftime('%F'),
                             end_date: range[1].days.ago.strftime('%F'),
                             description: 'Foo')

        ret = Event.all_between(4.days.ago.strftime('%F'),
                                2.days.ago.strftime('%F'))

        expect(ret).not_to include(event)
      end
    end
  end
end
