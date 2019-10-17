# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.paginate(page: params[:page])
  end
end
