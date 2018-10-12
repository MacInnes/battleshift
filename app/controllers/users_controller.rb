class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.generate_api_key
      session[:id] = @user.id
      redirect_to dashboard_path
    else
      redirect_to('/register', notice: 'Invalid registration details.')
    end
  end

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

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
