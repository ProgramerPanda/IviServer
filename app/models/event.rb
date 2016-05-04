class Event < ActiveRecord::Base


  attr_accessible :user_id, :location, :describe, :discount, :store
  belongs_to :user

  validates :user_id, presence: true

  validates :location, presence: true

  validates :describe, presence: true

end
