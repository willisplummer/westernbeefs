require "rails_helper"
describe "Viewing the list of articles" do
	it "shows the article" do
		article = Article.create(article_attributes)
		article2 = Article.create(article_attributes(title: "test2", author: "test author2", slug: "test2"))

		visit root_url

		expect(page).to have_text("test by test author")
		expect(page).to have_text("test2 by test author2")
	end
end