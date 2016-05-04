class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  attr_accessible :user_id, :event_id, :content

  validates :user_id, presence: true

  validates :content, presence: true

  validates :event_id, presence: true
end
