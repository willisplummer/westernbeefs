class AddContentPageColumnToArticles < ActiveRecord::Migration
  def change
  	add_column :articles, :has_index, :boolean, default: false
  end
end
