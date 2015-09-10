class StoriesController < ApplicationController
	http_basic_authenticate_with name: ENV["my_admin_username"], password: ENV["my_admin_password"]


	def show
		@article = Article.find(params[:article_id])
  		@story = @article.stories.find(params[:id])
 	end

 	def new
  		@article = Article.new
  	end

	def edit
    	@article = Article.find(params[:article_id])
  		@story = @article.stories.find(params[:id])
  	end

	def create
		@article = Article.find(params[:article_id])
		@story = @article.stories.create(story_params)
		redirect_to article_admin_path(@article)
	end

	def update
    	@article = Article.find(params[:id])
    	@story = @article.stories.find(params[:id])


    	if @story.update(story_params)
      		redirect_to article_admin_path(@article)
   		else
      		render 'edit'
    	end
  	end

	def destroy
		@article = Article.find(params[:article_id])
		@story = @article.stories.find(params[:id])
		@story.destroy
		redirect_to article_admin_path(@article)
	end

	private
		def story_params
			params.require(:story).permit(:title, :slug)
		end
end