class PagesController < ApplicationController
	http_basic_authenticate_with name: ENV["my_admin_username"], password: ENV["my_admin_password"], except: :show
	before_filter :load_paginable

	def show
		@article = Article.find(params[:article_id])
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
    	if @page.paginable_type == "Article"
			redirect_to article_admin_path(id: @paginable)
	    elsif @page.paginable_type == "Story"
	    	redirect_to article_story_admin_path(article_id: @paginable.article, id: @paginable)
	    end
	end

	def update
    	@page = @paginable.pages.find(params[:id])

    	if @page.paginable_type == "Article"
	    	if @page.update(page_params)
	      		redirect_to article_admin_path(id: @paginable)
	   		else
	      		render 'edit'
	    	end
	    elsif @page.paginable_type == "Story"
	    	if @page.update(page_params)
	      		redirect_to article_story_admin_path(article_id: @paginable.article, id: @paginable)
	   		else
	      		render 'edit'
	    	end
	    end
  	end

	def destroy
		@article = Article.find(params[:article_id])
		@page = @paginable.pages.find(params[:id])
		@page.destroy
		redirect_to article_admin_path(@article)
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
		params.require(:page).permit(:page_number, :body)
	end
end