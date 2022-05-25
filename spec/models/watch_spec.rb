require 'rails_helper'

RSpec.describe Watch, type: :model do
  let(:show) { Show.new(name: "Name", year: 2022) }
  let(:season) { Season.new(number: 1, show: show) }
  let(:episode) { Episode.new(name: "Name", number: 1, season: season) }
  let(:watch) { Watch.new(priority: "Low", show: show, last_episode: episode) }

  it 'is valid with all attributes' do
    expect(watch).to be_valid
  end

  context 'priority' do
    it 'should be present' do
      watch.priority = nil
      expect(watch).to_not be_valid
    end
  end

  context 'show' do
    it 'should be present' do
      watch.show = nil
      expect(watch).to_not be_valid
    end
  end

  context 'last_episode' do
    it 'should be present' do
      watch.last_episode = nil
      expect(watch).to_not be_valid
    end
  end
end
