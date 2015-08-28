class StoryPage < ActiveRecord::Base
	extend FriendlyId
	friendly_id :slug
  	
  	belongs_to :story
end
