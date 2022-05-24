class Episode < ApplicationRecord
  belongs_to :season

  validates :number, presence: true, numericality: { greater_than: 0 }
  validates :name, presence: true
end
