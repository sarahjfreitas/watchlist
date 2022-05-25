require 'rails_helper'

RSpec.describe Season, type: :model do
  let(:show) { Show.new(name: "Name", year: 2022) }
  let(:season) { Season.new(number: 1, show: show) }

  it 'is valid with all attributes' do
    expect(season).to be_valid
  end

  context 'number' do
    it 'should be present' do
      season.number = nil
      expect(season).to_not be_valid
    end

    it 'must be a number' do
      season.number = "Number"
      expect(season).to_not be_valid
    end
  end

  context 'show' do
    it 'should be present' do
      season.show = nil
      expect(season).to_not be_valid
    end
  end
end
