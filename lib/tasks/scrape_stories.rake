desc "Fetch story data"
task :fetch_stories => :environment do
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
		c = content_url.sub(ARTICLE_URL+"/", "")
		c.sub("/01", "")
	end

	def get_body_width(content_url)
		page_css = CssParser::Parser.new
		page_css.add_block!(open(content_url).read)
		content_style = page_css.find_by_selector('#content')
		content_style_string = content_style[0]
		body_width_string = content_style_string.match(/width: ?\d+px/)[0]
		body_width_string.match(/\d+/)[0].to_i
	end

	def get_content_url(story_links, i)
		content_path = story_links.css('a')[i]['href']
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
	ARTICLE_URL = "http://westernbeefs.com/mcclanahan"
	home_page = Nokogiri::HTML(open(ARTICLE_URL).read)
	article = Article.find("mcclanahan")
	#selects only links (e.g. <a href="">) inside of the content div
	story_links = home_page.css("#content a")
	#selects each url on /mcclanahan, navigates there, and starts scraping
	story_links.each_with_index do |p, i|
		story = article.stories.new
		content_url = get_content_url(story_links, i)
		slug = get_slug(content_url)
		first_page = get_first_page(content_url)		
		title = first_page.css('h1')[0].inner_html
		page_count = 5
		story.update_attributes(:title => title, :slug => slug, :page_count => page_count)
		page_number = 1
		puts "page: #{page_number}"
		page_body = fix_non_breaking_spaces(first_page.css('#content').inner_html)
		story.pages.create(page_number: page_number, body: page_body)
		footer_links = first_page.css('#nav a')
		next_page_url = BASE_URL + footer_links.css('a')[0]['href']
		until next_page_url == ARTICLE_URL do
			page_number += 1
			puts "page: #{page_number}"
			page = Nokogiri::HTML(open(next_page_url).read)
			page_body  = fix_non_breaking_spaces(page.css('#content').inner_html)
			story.pages.create(page_number: page_number, body: page_body)
			footer_links = page.css('#nav a')
			next_page_url = BASE_URL + footer_links.css('a')[1]['href']
		end
		story.update_attributes(:page_count => story.pages.count)
	end
end
