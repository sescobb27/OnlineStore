class SessionsController < ApplicationController
  skip_before_filter :authorize
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
      redirect_to log_in_path, notice: "Invalid Username or Password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_path, notice: "Logged Out"
  end
end
