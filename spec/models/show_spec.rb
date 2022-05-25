require 'rails_helper'

RSpec.describe Show, type: :model do
  let(:show) { Show.new(name: "Name", year: 2022) }

  it 'is valid with all attributes' do
    expect(show).to be_valid
  end

  it 'should have a name' do
    show.name = nil
    expect(show).to_not be_valid
  end

  context 'the year' do
    it 'should be present' do
      show.year = nil
      expect(show).to_not be_valid
    end

    it 'must be a number' do
      show.year = "Year"
      expect(show).to_not be_valid
    end

    it 'cannot be smaller than 1500' do
      show.year = 30
      expect(show).to_not be_valid
    end

    it 'cannot be bigger than 2500' do
      show.year = 5000
      expect(show).to_not be_valid
    end
  end
end
