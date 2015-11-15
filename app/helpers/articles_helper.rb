module ArticlesHelper
	def get_url(article, page, bio)	
		if page
			page.paginable_type == "Article" ? article_page_url(article, page) : story_page_url(article, page.paginable, page)
		elsif bio
			article_bio_url(article)
		else
			article_url(article)
		end
	end
end
