class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      flash[:notice] = "Be a friend"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @friendship.errors.full_message.to_sentence
      redirect_back(fallback_location: root_path)

    end

  end

  def destroy
    @friendship = current_user.friendships.where(friend_id: params[:id]) 
    if @friendship == nil
    else
      @friendship = current_user.inverse_friends.where(friend_id: params[:id])
    end

    
  
    @friendship.destroy_all
    flash[:alert] = "解除好友"
    redirect_back(fallback_location: root_path)

  end

  



end
