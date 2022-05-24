class Season < ApplicationRecord
  belongs_to :show

  validates :number, presence: true, numericality: { greater_than: 0 }
end
