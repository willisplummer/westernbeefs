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

	def first
		page_count == 0 ? 'bio' : '01'
	end

	def author_slug
		author.split.last.downcase
	end

	def page_count_zerod
		page_count.to_s.rjust(2, '0')
	end

	def last_page
		page_count == 0 ? nil : page_count_zerod
	end

	extend FriendlyId
	friendly_id :author_slug, use: [:slugged, :finders]
end
