class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
  @user = User.find(params[:id])
  end

  def create 
    @user = User.new(params.require(:user).permit(:username, :email, :password))
    if @user.save
      redirect_to '/'
    else
      render :new, status: :unprocessable_entity
      end
    end
  end