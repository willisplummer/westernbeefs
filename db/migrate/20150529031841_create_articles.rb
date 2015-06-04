class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :author
      t.string :author_slug
      t.text :text
      t.integer :page_count


      t.timestamps null: false
    end
  end
end
