class UsersController < ApplicationController
  def show
    @user = UserSearchResult.new(params[:id]).user
  end

  def index
    @users = UserSearchResult.new.users
  end
end