class SessionsController < ApplicationController
  
  def new
    
  end
  def create
    user = User.find_by_name(params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      respond_to do |format|
        format.html { redirect_to store_path, notice: "Logged In" }
      end
    else
      flash.now.alert = "Invalid Username or Password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_path, notice: "Logged Out"
  end
end
