class CategoriesController < ApplicationController
before_action :require_admin, except: [:index, :show]  


  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category, notice: "Category was successfully created"
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def index
    @categories = Category.all
    # @categories = Category.paginate(pages: params[:page], per_page: 5)
  end
  
  def show
    @category = Category.find(params[:id])
    @articles = @category.articles
  end

  def edit
    @category= Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to @category, notic: "Category name edited successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end
private
  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if  !(logged_in? && current_user.admin?) 
      redirect_to categories_path, notice: "Only admins can do this!!"
      end
  end

end