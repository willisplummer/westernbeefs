class PagesController < ApplicationController
	http_basic_authenticate_with name: ENV["BLOG_USERNAME"], password: ENV["BLOG_PASSWORD"], except: :show
	before_filter :load_paginable

	def show
  		@page = @paginable.pages.find(params[:id])
 	end

 	def new
  		@page = @paginable.pages.new
  	end

	def edit
  		@page = @paginable.pages.find(params[:id])
  	end

	def create
		@page = @paginable.pages.create(page_params)
		redirect_to @paginable
	end

	def update
    	@page = @paginable.pages.find(params[:id])

    	if @page.update(page_params)
      		redirect_to @paginable
   		else
      		render 'edit'
    	end
  	end

	def destroy
		@page = @paginable.pages.find(params[:id])
		@page.destroy
		redirect_to @paginable
	end

private
	def load_paginable
		if params[:story_id]
		  @paginable = Story.find(params[:story_id])
		elsif params[:article_id]
	      @paginable = Article.find(params[:article_id])
	  end
	end

	def page_params
		params.require(:page).permit(:page_number, :body, :page_title)
	end
end