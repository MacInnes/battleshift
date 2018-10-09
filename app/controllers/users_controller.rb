class UsersController < ApplicationController

  def show
    @user = UserService.find(params[:id])
  end

end
