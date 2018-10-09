class UsersController < ApplicationController

  def show
    search = UserSearch.new
    @user = search.find_user(params[:id])
  end

  def index
    search = UserSearch.new
    @users = search.find_all_users
  end

end
