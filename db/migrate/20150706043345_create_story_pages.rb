class CreateStoryPages < ActiveRecord::Migration
  def change
    create_table :story_pages do |t|
      t.integer :page_number
      t.text :body
      t.string :slug
      t.string :page_title
      t.references :story, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
