class Event < ActiveRecord::Base


  attr_accessible :user_id, :location, :describe, :discount, :store
  belongs_to :user
  
end
