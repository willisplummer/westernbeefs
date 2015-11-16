require "rails_helper"
describe "Viewing the article" do
  it "shows page 1 of the article" do
    article = Article.create(article_attributes)

    visit article_url(article)

    expect(page).to have_text("test")
    expect(page).to have_text("test author")
    expect(page).to have_text("test first page")
    expect(page).to have_text(">")
  end
end
