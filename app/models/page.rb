class Page < ActiveRecord::Base
	belongs_to :article

	extend FriendlyId
	friendly_id :page_number, use: [:scoped, :finders], :scope => :article
end