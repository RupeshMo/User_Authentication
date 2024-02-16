class ArticlesController < ApplicationController
before_action :set_article, except: [:index, :new, :create]
before_action :require_user, except: [:index, :show]
before_action :require_same_user, except: [:index, :show]

  def index
    @articles = Article.all
  end

  def show
    # @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(require_params)
    @article.user = current_user
    if @article.save
      redirect_to article_path(@article)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @article = Article.find(params[:id])
    # render plain: @article.user.id
  end

  def update
    # @article = Article.find(params[:id])
    if @article.update(require_params)
      redirect_to article_path(@article)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # @article = Article.find(params[:id])
    @article.destroy
    redirect_to '/', status: :see_other, notice: "Article deleted sucessfully"
  end

  private

  def require_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      redirect_to '/articles', notice: "login to create new articles!!"
    end
  end

  def set_article
    @article = Article.find(params[:id])
  end

  # def require_user
  #   if !logged_in? && current_user != @user
end