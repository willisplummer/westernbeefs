class Page < ActiveRecord::Base
	belongs_to :paginable, polymorphic: true

	validates_numericality_of :page_number, greater_than: 0

	def page_zerod(p)
		p.to_s.rjust(2, '0')
	end


#these should both be helpers 

	def page_prev
		path = []
		prev_page = page_zerod(page_number - 1)

		case paginable_type
		when "Article"
			path << paginable.slug
			path << prev_page if page_number > 1
		when "Story"
			path << paginable.article.slug
			path << [paginable.slug, prev_page] if page_number > 1
		end

		path.join('/')
	end

	def page_next
		path = []
		next_page = page_zerod(page_number + 1)
		case paginable_type
		when "Article"
			path << paginable.slug
			page_number == paginable.page_count ? path << "bio" : path << next_page
		when "Story"
			path << paginable.article.slug
			path << [paginable.slug, next_page] if page_number != paginable.page_count
		end

		path.join('/')
	end

	def page_number_zerod 
		page_zerod(page_number)
	end
	
	extend FriendlyId
	friendly_id :page_number_zerod, use: [:scoped, :finders], :scope => [:paginable, :paginable_type]
end