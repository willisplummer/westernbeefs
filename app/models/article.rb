class Article < ActiveRecord::Base
	has_many :pages, dependent: :destroy
	validates :title, presence: true,
					  length: { minimum: 5 }
	def slug
		author.split.last.downcase
	end
end
