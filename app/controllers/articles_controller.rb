class ArticlesController < ApplicationController
  http_basic_authenticate_with name: ENV["my_admin_username"], password: ENV["my_admin_password"], except: [:index, :show, :bio]
  before_action :set_article, only: [:show, :admin, :editslug, :bio, :edit, :update, :destroy]

  def index
  	@articles = Article.all.order(created_at: :desc)
  end

  def admin_index
    @articles = Article.all.order(created_at: :desc)
  end

  def show
  end

  def admin
  end

  def editslug
  end

  def bio
    @bio = true
  end
  
  def new
  	@article = Article.new
  end

  def edit
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
    if @article.update(article_params)
      redirect_to article_admin_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to admin_index_path
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

  	def article_params
  		params.require(:article).permit(:title, :bio, :author_url, :slug, :first_page, :author, :body_width, :has_index, :page_count)
  	end
end