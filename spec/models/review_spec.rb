require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:show) { Show.new(name: "Name", year: 2022) }
  let(:review) { Review.new(author: "Author", stars: 4, content: "Review content", show: show) }

  it 'is valid with all attributes' do
    expect(review).to be_valid
  end

  context 'author' do
    it 'should be present' do
      review.author = ""
      expect(review).to_not be_valid
    end
  end

  context 'content' do
    it 'should be present' do
      review.content = ""
      expect(review).to_not be_valid
    end
  end

  context 'stars' do
    it 'should be present' do
      review.stars = nil
      expect(review).to_not be_valid
    end

    it 'must be a number' do
      review.stars = "Number"
      expect(review).to_not be_valid
    end

    it 'must be bigger than 0' do
      review.stars = 0
      expect(review).to_not be_valid
    end

    it 'cannot be bigger than 5' do
      review.stars = 6
      expect(review).to_not be_valid
    end
  end

  context 'show' do
    it 'should be present' do
      review.show = nil
      expect(review).to_not be_valid
    end
  end
end
