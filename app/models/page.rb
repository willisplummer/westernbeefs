class Page < ActiveRecord::Base
	belongs_to :paginable, polymorphic: true

	def page_nav_zerod(p)
		p.to_s.rjust(2, '0')
	end

	def page_prev
		if paginable_type == "Article"
			if page_number == 1
				"#{paginable.slug}"
			else
				prev_page = page_nav_zerod(page_number - 1)
				"#{paginable.slug}/#{prev_page}"
			end
		elsif paginable_type == "Story"
			if page_number == 1
				"#{paginable.article.slug}"
			else
				prev_page = page_nav_zerod(page_number - 1)
				"#{paginable.article.slug}/#{paginable.slug}/#{prev_page}"
			end
		end
	end

	def page_next
		if paginable_type == "Article"
			if page_number == paginable.page_count
				"#{paginable.slug}/bio"
			else
				next_page = page_nav_zerod(page_number + 1)
				"#{paginable.slug}/#{next_page}"
			end
		elsif paginable_type == "Story"
			if page_number == paginable.page_count
				"#{paginable.article.slug}"
			else
				page_number + 1
				next_page = page_nav_zerod(page_number + 1)
				"#{paginable.article.slug}/#{paginable.slug}/#{next_page}"
			end
		end
	end

	def page_number_zerod
	  page_number.to_s.rjust(2, '0')
	end

	extend FriendlyId
	friendly_id :page_number_zerod, use: [:scoped, :finders], :scope => [:paginable, :paginable_type]
end