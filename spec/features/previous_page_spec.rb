#this is still not working - capybara doesn't detect the back arrow

# require "rails_helper"

# describe "Clicking the back arrow from the bio when there are 0 pages" do
# 	it "shows the first page of the article" do
# 		article = Article.create(article_attributes)

# 		visit article_bio_url(article)
# 		click_link('<')

# 		expect(page).to have_text("test")
# 		expect(page).to have_text("test author")
# 		expect(page).to have_text("test first page")
# 	end
# end

# describe "Clicking the back arrow when there is 1 page" do
# 	it "shows the first page of the article" do
# 		article1 = Article.create(article_attributes(slug: "test1", author: "test author1", page_count: 1))
# 		testpage = article1.pages.create(page_number: 1, body: "test page 1")
# 		visit article_bio_url(article1)
# 		click_link('<')

# 		expect(page).to have_text("test page 1")
# 		expect(page).to have_text("test author1")
# 	end
# end
