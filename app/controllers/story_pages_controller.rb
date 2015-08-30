class StoryPagesController < ApplicationController

	http_basic_authenticate_with name: ENV["BLOG_USERNAME"], password: ENV["BLOG_PASSWORD"], except: :show


	def show
		@article = Article.find(params[:article_id])
  		@story = @article.stories.find(params[:story_id])
  		@story_page = @article.stories.story_pages.find(params[:id])
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
		def story_page_params
			params.require(:story_page).permit(:page_title, :page_number, :body)
		end
end