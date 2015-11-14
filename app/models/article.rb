class Article < ActiveRecord::Base
	has_many :pages, as: :paginable, dependent: :destroy
	has_many :stories, dependent: :destroy
	
	validates_presence_of :title, :author, :slug, :bio, :first_page, :page_count
	
	validates :slug, uniqueness: { case_sensitive: false }

	validates :author, uniqueness: { case_sensitive: false }

	validates :author_url, allow_blank: true, format: {
		with: /https?:\/\/.+\..+/,
		message: "url must begin with http:// or https://"
	}

	def author_slug
		author.split.last.downcase
	end

	# def page_count
	# 	pages.count
	# end

	extend FriendlyId
	friendly_id :author_slug, use: [:slugged, :finders]
end
