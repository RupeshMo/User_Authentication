class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  @user = User.find(params[:id])
    if @user.update(params_hash)
      redirect_to user_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  @user = User.find(params[:id])
  end

  def create 
    @user = User.new(params_hash)
    if @user.save
      redirect_to '/users/:id'
    else
      render :new, status: :unprocessable_entity
      end
  end


    private
    def params_hash
      params.require(:user).permit(:username, :email, :password)
    end
  end