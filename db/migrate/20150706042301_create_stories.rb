class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.string :slug
      t.integer :page_count
      t.references :article, index: true, foreign_key: true
      
      t.timestamps null: false
    end
  end
end
