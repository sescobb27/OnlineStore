class StoreController < ApplicationController
  def index
    @products = Product.all
    unless session[:counter]
      @cont = 0
      session[:counter] = @cont
    else
      session[:counter]+=1
    end
  end
end
