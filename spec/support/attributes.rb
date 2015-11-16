def article_attributes(overrides = {})
  {
    title: "test", 
    author: "test author",
    author_url: "https://wikipedia.org",
    slug: "test", 
    bio: "test bio", 
    first_page: "test first page", 
    page_count: 0,
    has_index: false
  }.merge(overrides)
end
