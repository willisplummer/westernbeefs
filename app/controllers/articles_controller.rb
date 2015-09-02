class ArticlesController < ApplicationController
  http_basic_authenticate_with name: ENV["BLOG_USERNAME"], password: ENV["BLOG_PASSWORD"], except: [:index, :show, :bio]
  before_filter :load_paginable

  def index
  	@articles = Article.all.order(created_at: :desc)
  end

  def admin_index
    @articles = Article.all.order(created_at: :desc)
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

    redirect_to admin_index_path
  end

  private
  	def article_params
  		params.require(:article) .permit(:title, :bio, :author_url, :page_count, :first_page, :author, :first_page_title, :body_width)
  	end
end