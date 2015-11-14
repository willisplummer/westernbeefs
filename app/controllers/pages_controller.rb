class PagesController < ApplicationController
	http_basic_authenticate_with name: ENV["my_admin_username"], password: ENV["my_admin_password"], except: :show
	before_filter :load_paginable
	before_action :set_page, only: [:show, :edit, :update, :destroy]

	def show
		@article = Article.find(params[:article_id])
 	end

 	def new
		@page = @paginable.pages.new
	end

	def edit
	end

	def create
		@page = @paginable.pages.new(page_params)
		if @page.save
			redirect_to_correct_admin_path(@page, @paginable)
		else
			render 'edit'
		end
	end

	def update
    if @page.update(page_params)
      redirect_to_correct_admin_path(@page, @paginable)
   	else
      render 'edit'
    end
	end

	def destroy
		@page.destroy
		redirect_to_correct_admin_path(@page, @paginable)
	end

	private
		def load_paginable
			if params[:story_id]
			  @paginable = Story.find(params[:story_id])
			elsif params[:article_id]
		    @paginable = Article.find(params[:article_id])
		  end
		end

		def set_page
			@page = @paginable.pages.find(params[:id])
		end

		def redirect_to_correct_admin_path(page, paginable)
			if page.paginable_type == "Story"
				redirect_to article_story_admin_path(article_id: paginable.article, id: paginable)
			else
				redirect_to article_admin_path(paginable)
	    end
		end

		def page_params
			params.require(:page).permit(:page_number, :body)
		end
end
