class RestaurantsController < ApplicationController

  
  def index
    @categories = Category.all
    if 
      params[:search]
      @restaurants = Restaurant.where('name LIKE ?', "%#{params[:search]}%")
      
    else
      @restaurants = Restaurant.page(params[:page]).per(9)
      
    end
  end
  
   def show
    @restaurant = Restaurant.find(params[:id])
    @comment = Comment.new  
  end



end
