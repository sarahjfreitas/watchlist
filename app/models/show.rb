class Show < ApplicationRecord
  validates :name, presence: true
  validates :year, presence: true, inclusion: { in: 1500..2500 }
end
