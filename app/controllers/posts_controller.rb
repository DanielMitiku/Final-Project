# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: %i[destroy edit update]

  def new
    @post = current_user.posts.new
  end

  def index
    @like = Like.new
    @comment = Comment.new
    @posts = current_user.posts.paginate(page: params[:page])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'Post has been created!'
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = 'Post updated'
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    if @post
      @post.destroy
      flash[:success] = 'Post has been deleted'
    else
      flash[:alert] = 'Error, Please try again'
    end
    redirect_to root_path
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to posts_path if @post.nil?
  end
end
