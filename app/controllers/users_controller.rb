class UsersController < ApplicationController

  def show
    search = UserSearch.new
    @user = search.find_user(params[:id])
    if @user.id == nil
      render status: 400
    end
  end

  def index
    search = UserSearch.new
    @users = search.find_all_users
  end

  def edit
    search = UserSearch.new
    @user = search.find_user(params[:id])
    if @user.id == nil
      render status: 400
    end
  end

  def update
    search = UserSearch.new
    user = search.update_user(params[:id], params[:email])
    flash[:success] = "Successfully updated #{user.name}."
    redirect_to users_path
  end

end
