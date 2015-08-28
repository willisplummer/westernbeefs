class Story < ActiveRecord::Base
	extend FriendlyId
	friendly_id :slug

 	belongs_to :article
 	has_many :story_pages
end