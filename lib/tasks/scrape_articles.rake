desc "Fetch article data"
task :fetch_articles => :environment do
	require 'nokogiri'
	require 'open-uri'
	require 'css_parser'


	def get_page_count(bio_page)
		unless bio_page.css("#nav a")[0] == nil
			footer_links = bio_page.css('#nav a')
			last_page_url = BASE_URL + footer_links.css('a')[0]['href']
			if last_page_url.match(/[0-9]+/)
				last_page_url.match(/[0-9]+/)[0].to_i
			else
				0
			end
		else
			0
		end
	end

	def get_slug(content_url)
		content_url.sub(BASE_URL+"/", "")
	end

	def get_body_width(content_url)
		page_css = CssParser::Parser.new
		page_css.add_block!(open(content_url).read)
		content_style = page_css.find_by_selector('#content')
		content_style_string = content_style[0]
		body_width_string = content_style_string.match(/width: ?\d+px/)[0]
		body_width_string.match(/\d+/)[0].to_i
	end

	def get_content_url(content_links, i)
		content_path = content_links.css('a')[i]['href']
		BASE_URL + content_path
	end

	def get_first_page(content_url)
		Nokogiri::HTML(open(content_url).read)
	end

	def get_bio_page(content_url)
		bio_url = content_url + '/bio'
		Nokogiri::HTML(open(bio_url).read)
	end

	def fix_non_breaking_spaces(page_body)
		page_body.gsub(/&amp;nbsp/, "&nbsp;")
	end

	BASE_URL = "http://westernbeefs.com"
	home_page = Nokogiri::HTML(open(BASE_URL).read)
	#selects only links (e.g. <a href="">) inside of the content div
	content_links = home_page.css("#content a").reverse
	#selects each url on the index of the homepage, navigates there, and starts scraping
	content_links.each_with_index do |p, i|
		new_article = Article.new
		content_url = get_content_url(content_links, i)
		#moving to the first page of the collection
		first_page = get_first_page(content_url)
		first_page_body  = fix_non_breaking_spaces(first_page.css('#content').inner_html)
		slug = get_slug(content_url)
		body_width = get_body_width(content_url)
		
		#moving to the bio
		bio_page = get_bio_page(content_url)
		author = bio_page.css("#author a").text
		title = bio_page.css('h1')[0].text
		author_url = bio_page.css("#author a")[0]['href']
		author_bio  = bio_page.css('#content').inner_html
		page_count = get_page_count(bio_page)

		new_article.update_attributes(:title => title, :bio => author_bio, :author_url => author_url, :page_count => page_count, :first_page => first_page_body, :author => author, :slug => slug, :body_width => body_width)
	end
end