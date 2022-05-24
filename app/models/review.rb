class Review < ApplicationRecord
  belongs_to :show

  validates :author, presence: true
  validates :content, presence: true
  validates :stars, presence: true, inclusion: { in: 1..5 }
end
