class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]

  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end

  def edit
  
  end

  def update
  
    if @user.update(params_hash)
      redirect_to user_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  
  end

  def create 
    @user = User.new(params_hash)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new, status: :unprocessable_entity
      end
  end


    private
    def params_hash
      params.require(:user).permit(:username, :email, :password)
    end

    def set_user
      @user = User.find(params[:id])
    end
  end