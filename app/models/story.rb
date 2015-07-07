class Story < ActiveRecord::Base
  	belongs_to :article

 	extend FriendlyId

end
