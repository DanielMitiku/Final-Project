# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @like = Like.new
    @comment = Comment.new
    @posts = current_user.feed.paginate(page: params[:page]) if user_signed_in?
  end
end
