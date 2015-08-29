desc "Fetch article pages"
task :fetch_article_pages => :environment do
	require 'nokogiri'
	require 'open-uri'
	require 'css_parser'

	def page_number_zerod(page_number)
	  page_number.to_s.rjust(2, '0')
	end

	BASE_URL = "http://westernbeefs.com/"
	Article.all.each do |article|
		next if article.slug == "mcclanahan"
		puts "article: #{article.title}"
		page_number = 1
		if article.page_count > 0
			article.page_count.times do
				puts "page: #{page_number}"
				page_url = BASE_URL + article.slug + "/" + page_number_zerod(page_number)
				page = Nokogiri::HTML(open(page_url).read)
				page_body  = page.css('#content').inner_html
				article.pages.create(page_number: page_number, body: page_body)
				page_number += 1
			end
		end
	end
end