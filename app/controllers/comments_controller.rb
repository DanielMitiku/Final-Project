# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: %i[destroy update]

  def create
    @comment = current_user.comments.build(comment_params)
    @post = Post.find_by(id: params[:comment][:post_id])
    @comment.post = @post
    if @comment.save
      flash[:success] = 'Comment created!'
    else
      flash[:danger] = 'Error in Creating Comment!'
    end
    redirect_to root_path
  end

  def edit
    @comment = current_user.comments.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(comment_params)
      flash[:success] = 'Comment updated'
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    @comment = current_user.comments.find_by(id: params[:comment][:id])
    if @comment
      @comment.destroy
      flash[:success] = 'Comment has been deleted'
    else
      flash[:alert] = 'Error, Please try again'
    end
    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def correct_user
    @comment = current_user.comments.find_by(id: params[:comment][:id]) || current_user.comments.find(params[:id])
    redirect_to root_path if @comment.nil?
  end
end
