class ArticlesController < ApplicationController
before_action :set_article, except: [:index, :new, :create]
before_action :require_user, only: [:show, :new, :create, :edit, :update, :destroy]
before_action :require_same_user, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def show
    
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
    # debugger
  end

  def update
    if @article.update(require_params)
      redirect_to current_user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    redirect_to current_user, status: :see_other, notice: "Article deleted sucessfully"
  end

  private

  def require_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      redirect_to '/articles', notice: "Not Authorized to perform action"
    end
  end

  def set_article
    @article = Article.find(params[:id])
  end

end