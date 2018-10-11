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
    @user  = search.find_user(params[:id])
    render status: 400 if @user.nil?
  end

  def update
    search = UserSearch.new
    payload_params = {
      email: params[:email]
    }
    search.update_user(params[:id], payload_params)

    user  = search.find_user(params[:id])
    redirect_to('/users', notice: "Successfully updated #{user.name}")
  end

end
