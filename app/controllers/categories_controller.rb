class CategoriesController < ApplicationController

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
  end
  
  def show
  end

  def category_params
    params.require(:category).permit(:name)
  end
end