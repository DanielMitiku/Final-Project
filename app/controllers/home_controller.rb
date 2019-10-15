class HomeController < ApplicationController
  def index
    @posts = Post.paginate(page: params[:page])
  end
end
