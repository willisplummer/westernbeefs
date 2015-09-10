class DropStoryPagesTable < ActiveRecord::Migration
  def change
  	drop_table :story_pages
  end
end
