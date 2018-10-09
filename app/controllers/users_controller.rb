class UsersController < ApplicationController
  def show
    @user = UserSearchResult.new(params[:id]).user
  end
end