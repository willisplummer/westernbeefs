class PagesController < ApplicationController

	def show
		@article = Article.find(params[:article_id])
  		@page = @article.pages.find(params[:id])
 	end

	def create
		@article = Article.find(params[:article_id])
		@page = @article.pages.create(page_params)
		redirect_to article_admin_path(@article)
	end

	def destroy
		@article = Article.find(params[:article_id])
		@page = @article.pages.find(params[:id])
		@page.destroy
		redirect_to article_admin_path(@article)
	end

	private
		def page_params
			params.require(:page).permit(:page_number, :body)
		end
end