# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: %i[destroy]

  def create
    @like = current_user.likes.build(like_params)
    @post = Post.find_by(id: params[:like][:post_id])
    @like.post = @post
    if @like.save
      flash[:success] = 'You liked this post!'
    else
      flash[:danger] = 'Error!'
    end
    redirect_to root_path
  end

  def destroy
    @like = current_user.likes.find_by(post_id: params[:post][:id])
    if @like
      @like.destroy
      flash[:success] = 'You unliked this post'
    else
      flash[:alert] = 'Error, Please try again'
    end
    redirect_to root_path
  end

  private

  def like_params
    params.require(:like).permit
  end

  def correct_user
    @like = current_user.likes.find_by(post_id: params[:post][:id]) || current_user.likes.find(params[:id])
    redirect_to root_path if @like.nil?
  end
end
