class Story < ActiveRecord::Base
 	belongs_to :article
	has_many :pages, as: :paginable, dependent: :destroy

	extend FriendlyId
	friendly_id :slug, use: [:slugged, :finders]
end