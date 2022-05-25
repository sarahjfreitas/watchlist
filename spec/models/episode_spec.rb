require 'rails_helper'

RSpec.describe Episode, type: :model do
  let(:show) { Show.new(name: "Name", year: 2022) }
  let(:season) { Season.new(number: 1, show: show) }
  let(:episode) { Episode.new(name: "Name", number: 1, season: season) }

  it 'is valid with all attributes' do
    expect(episode).to be_valid
  end

  context 'number' do
    it 'should be present' do
      episode.number = nil
      expect(episode).to_not be_valid
    end

    it 'must be a number' do
      episode.number = "Number"
      expect(episode).to_not be_valid
    end

    it 'must be positive' do
      episode.number = -3
      expect(episode).to_not be_valid
    end
  end

  context 'name' do
    it 'should be present' do
      episode.name = nil
      expect(episode).to_not be_valid
    end
  end
end
