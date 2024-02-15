class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
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
    @article = Article.find(params[:id])
    # render plain: @article.user.id
    
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(require_params)
      redirect_to article_path(@article)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def require_params
    params.require(:article).permit(:title, :description)
  end

  
  # def require_user
  #   if !logged_in? && current_user != @user
end