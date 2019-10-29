class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: %i[destroy]

  def index
    @friends = current_user.friends
  end

  def notification
    @invitations = current_user.friend_requests
  end

  def update
    @friend = User.find_by(id: params[:id])
    current_user.confirm_friend(@friend)
    flash[:success] = "You are now Friends"
    redirect_to notifications_path
  end

  def create
    @friend = User.find_by(id: params[:friend][:id])
    if current_user.add_friend(@friend)
        flash[:success] = "Friend Request Sent"
    else 
        flash[:danger] = "Error Sending Friend Request"
    end
    redirect_to users_path
  end

  def destroy
    @friend = User.find_by(id: params[:id])
    if current_user.friend?(@friend) && current_user.remove_friend(@friend)
        flash[:success] = "Friend Removed"
    elsif current_user.pending_friends.include?(@friend) && current_user.remove_friend(@friend) 
        flash[:success] = "Friend Request Removed"
    else
        flash[:danger] = "Error Removing Friend"
    end
    redirect_to users_path
  end

  private

  def friendship_params
    params.require(:friendship).permit(:requestor_id, :requestee_id)
  end

  def correct_user
    @friend = User.find_by(id: params[:id])
    redirect_to root_path if current_user.friend?(@friend)
  end
end