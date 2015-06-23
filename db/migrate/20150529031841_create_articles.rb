class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :author
      t.string :slug
      t.string :author_url
      t.string :first_page_title
      t.text :first_page
      t.text :bio
      t.integer :page_count
      t.integer :body_width


      t.timestamps null: false
    end
  end
end
