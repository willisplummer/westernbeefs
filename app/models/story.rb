class Story < ActiveRecord::Base
	extend FriendlyId
	friendly_id :slug

 	belongs_to :article
end