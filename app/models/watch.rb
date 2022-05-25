class Watch < ApplicationRecord
  belongs_to :show
  belongs_to :last_episode, class_name: 'Episode', foreign_key: :last_episode_id

  validates :priority, presence: true
  validates :show_id, presence: true
  validates :last_episode_id, presence: true
end
