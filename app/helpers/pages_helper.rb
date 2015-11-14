module PagesHelper
	def page_prev(page)
		path = []
		prev_page = (page.page_number - 1).to_s.rjust(2, '0')

		case page.paginable_type
		when "Article"
			path << page.paginable.slug
			path << prev_page if page.page_number > 1
		when "Story"
			path << page.paginable.article.slug
			path << [page.paginable.slug, prev_page] if page.page_number > 1
		end

		path.join('/')
	end

	def page_next(page)
		path = []
		next_page = (page.page_number + 1).to_s.rjust(2, '0')

		case page.paginable_type
		when "Article"
			path << page.paginable.slug
			page.page_number == page.paginable.page_count ? path << "bio" : path << next_page
		when "Story"
			path << page.paginable.article.slug
			path << [page.paginable.slug, next_page] if page.page_number != page.paginable.page_count
		end

		path.join('/')
	end
end
