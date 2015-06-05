class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :author
      t.string :slug
      t.text :bio
      t.integer :page_count


      t.timestamps null: false
    end
  end
end
