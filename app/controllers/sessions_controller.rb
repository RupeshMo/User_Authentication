class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user, notice: "successful"
    else
      # flash.now[:notice] = "Something is wrong"
      redirect_to login_path, notice: "invalid email or password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/', notice: "logged out"
  end


end