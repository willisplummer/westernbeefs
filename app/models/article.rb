class Article < ActiveRecord::Base
	has_many :pages, dependent: :destroy
	validates_presence_of :title, :slug, :author, :page_count
	validates :author, uniqueness: { case_sensitive: false }

	def author_slug
		author.split.last.downcase
	end

	extend FriendlyId
	friendly_id :author_slug, use: :slugged


	
end
