module PagesHelper
	def page_prev(article, page, bio)
		if bio
			if article.page_count == 0
				%{<a href = "/#{article.slug}"><</a>}.html_safe 
			else
				%{<a href = "/#{article.slug}/#{article.page_count.to_s.rjust(2, '0')}"><</a>}.html_safe
			end
		elsif page
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
			%{<a href = /#{path.join('/')} ><</a>}.html_safe
		else
			%{<font color="red"><</font>}.html_safe
		end
	end

	def page_next(article, page, bio)
		if bio
			%{<a href = "/">></a>}.html_safe
		elsif page
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

			%{<a href = /#{path.join('/')} >></a>}.html_safe
		else
			if article.page_count == 0 
				%{<a href = "/#{article.slug}/bio">></a>}.html_safe
			else
				%{<a href = "/#{article.slug}/01">></a>}.html_safe
			end
		end
	end

	def show_page_number(article, page, bio)
		if article.has_index 
			bio ? "Bio" : page.page_number
		end
	end
end
