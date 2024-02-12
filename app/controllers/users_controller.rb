class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update, :show]

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
    if @user.nil? 
      redirect_to '/', notice: "Id Not found!"
    end
    # @user = User.find(params[:id])
    # render plain: "#{@user.username}, #{current_user.username}, #{logged_in?}"
    # if !logged_in? && @user != current_user
      
    #   redirect_to '/' , notice: "You are not logged in!! Permission denied"
    # end
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

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    
    # if @user == current_user
    redirect_to '/', status: :see_other, notice: "Account deleted sucessfully"
    
  end



    private
    def params_hash
      params.require(:user).permit(:username, :email, :password)
    end

    def set_user
      @user = User.find_by(id: params[:id])
    end

    def require_same_user
      if current_user != @user && !current_user.admin?
        # redirect_to login_path notice: "You can only edit or delete your own account" :: results in url : http://localhost:3000/login?notice=You+can+only+edit+or+delete+your+own+account
        redirect_to '/', notice: "You can only edit or delete your own account"
      end
  end
end