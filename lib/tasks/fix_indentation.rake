desc "Fuck up some commas"
task :fix_indentation => :environment do
  articles = ["fishkind", "humphreys", "ives"]
  articles.each do |article|
    a = Article.find(article)
    a.pages.each do |p|
      body = p.body
      puts body
      body = body.gsub(/\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;/, "<p>")
      body = body.gsub(/<br>/, "</p>")
      unless body.include?("<div id='tab'>") || body.include?('<div id="tab">')
        body = body.sub(/<\/p>/, "</p><div id='tab'>")
        body << "</div>"
      end
      puts body
      p.update(body: body)
    end 
  end

  a = Article.find("chen")
  body = a.first_page
  puts body
  body = body.gsub(/\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;/, "<p>")
  body = body.gsub(/<br>/, "</p>")
  unless body.include?("<div id='tab'>") || body.include?('<div id="tab">')
    body = body.sub(/<\/p>/, "</p><div id='tab'>")
    body << "</div>"
  end
  puts body
  a.update(first_page: body)

end
