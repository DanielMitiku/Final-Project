# frozen_string_literal: true

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
    flash[:success] = 'You are now Friends'
    redirect_to notifications_path
  end

  def create
    @friend = User.find_by(id: params[:friend][:id])
    if current_user.add_friend(@friend)
      flash[:success] = 'Friend Request Sent'
    else
      flash[:danger] = 'Error Sending Friend Request'
    end
    redirect_to users_path
  end

  def destroy
    @friend = User.find_by(id: params[:id])
    remove_friend(@friend)
    redirect_to users_path
  end

  private

  def friendship_params
    params.require(:friendship).permit(:requestor_id, :requestee_id)
  end

  def remove_friend(friend)
    if current_user.friend?(friend)
      flash[:success] = 'Friend Removed' if current_user.remove_friend(friend)
    elsif current_user.pending_friends.include?(friend)
      flash[:success] = 'Friend Request Removed' if current_user.remove_friend(friend)
    else
      flash[:danger] = 'Error Removing Friend'
    end
  end

  def correct_user
    @friend = User.find_by(id: params[:id])
    redirect_to root_path if !current_user.friend?(@friend) && !current_user.pending_friends.include?(@friend)
  end
end
