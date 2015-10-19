class RemovePageTitleColumnsFromArticlesAndPages < ActiveRecord::Migration
  def change
  	remove_column :articles, :first_page_title
  	remove_column :pages, :page_title
  end
end
