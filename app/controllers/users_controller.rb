class UsersController < ApplicationController

  def show
    search = UserSearch.new
    @user = search.find_user(params[:id])
  end

end
