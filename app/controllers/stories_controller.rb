class StoriesController < ApplicationController
	http_basic_authenticate_with name: ENV["my_admin_username"], password: ENV["my_admin_password"]
  before_action :set_article, only: [:show, :edit, :create, :update, :destroy]
  before_action :set_story, only: [:show, :edit, :update, :destroy]

	def show
 	end

 	def new
		@article = Article.new
	end

	def edit
	end

	def create
		@story = @article.stories.create(story_params)
		redirect_to article_admin_path(@article)
	end

	def update
  	if @story.update(story_params)
    		redirect_to article_admin_path(@article)
 		else
    		render 'edit'
  	end
	end

	def destroy
		@story.destroy
		redirect_to article_admin_path(@article)
	end

	private
	  def set_article
	    @article = Article.find(params[:article_id])
	  end

	  def set_story
	    @story = @article.stories.find(params[:id])
	  end

		def story_params
			params.require(:story).permit(:title, :slug)
		end
end