class RemoveArticleIndexFromPages < ActiveRecord::Migration
  def change
  	remove_index :pages, :article_id
  end
end
