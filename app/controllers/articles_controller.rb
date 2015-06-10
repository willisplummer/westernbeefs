class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "willis", password: "password",
except: [:index, :show]

  def index
  	@articles = Article.all
  end

  def admin_index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def admin
    @article = Article.find(params[:id])
  end

  def bio
    @article = Article.find(params[:id])
  end
  
  def new
  	@article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
  	@article = Article.new(article_params)

  	if @article.save
      redirect_to article_admin_path(@article)
  	else
  		render 'new'
  	end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to article_admin_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private
  	def article_params
  		params.require(:article) .permit(:title, :bio, :page_count, :first_page, :author)
  	end
end