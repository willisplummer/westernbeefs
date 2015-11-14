module ArticlesHelper
	def article_next(article)
		article.page_count == 0 ? "/#{article.slug}/bio" : "/#{article.slug}/01"
	end

	def article_bio_prev(article)
		article.page_count == 0 ? "/#{article.slug}" : "/#{article.slug}/#{article.page_count.to_s.rjust(2, '0')}"
	end
end
