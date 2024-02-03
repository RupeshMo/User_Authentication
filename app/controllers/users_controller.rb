class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create 
    @user = User.new(params.require(:user).permit(:username, :email, :password_digest))
    if @user.save
      redirect_to user_path
      
    else
      render :new
    end
  end
end
