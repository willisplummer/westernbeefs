class PagesController < ApplicationController

	http_basic_authenticate_with name: ENV["BLOG_USERNAME"], password: ENV["BLOG_PASSWORD"], except: :show


	def show
		@article = Article.find(params[:article_id])
  		@page = @article.pages.find(params[:id])
 	end

 	def new
  		@article = Article.new
  	end

	def edit
    	@article = Article.find(params[:article_id])
  		@page = @article.pages.find(params[:id])
  	end

	def create
		@article = Article.find(params[:article_id])
		@page = @article.pages.create(page_params)
		redirect_to article_admin_path(@article)
	end

	def update
    	@article = Article.find(params[:id])
    	@page = @article.pages.find(params[:id])


    	if @page.update(page_params)
      		redirect_to article_admin_path(@article)
   		else
      		render 'edit'
    	end
  end

	def destroy
		@article = Article.find(params[:article_id])
		@page = @article.pages.find(params[:id])
		@page.destroy
		redirect_to article_admin_path(@article)
	end

	private
		def page_params
			params.require(:page).permit(:page_number, :body, :page_title)
		end
end