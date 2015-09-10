class DropColumnArticleIdFromPages < ActiveRecord::Migration
  def change
  	remove_column :pages, :article_id
  end
end
