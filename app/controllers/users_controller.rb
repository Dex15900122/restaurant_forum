class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update, :friend_list]
  
  def index
  @users= User.all
  
  end 



  def show 
    @commented_restaurants = @user.restaurants
    @favorited_restaurants = @user.favorited_restaurants
    @followings = @user.followings
    @followers  =@user.followers
    @friends = @user.friends
    @inverse_friends =  @user.inverse_friends
  end


  def edit

    unless @user ==current_user
      redirect_to user_path(@user)
    end
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end
  def friend_list
     @friends = @user.friends
     @inverse_friends =  @user.inverse_friends
  end
  

  private

    def set_user
      @user = User.find(params[:id])
    end


    def user_params
      params.require(:user).permit(:name, :intro, :avator)
    end

  



 end
