class ActivateUserController < ApplicationController
  def update
    user = User.find(params[:user])

    if user.inactive? && user.api_key == params[:key]
      user.activate_account
      redirect_to('/dashboard', notice: 'Account activated!')
    else
      redirect_to('/dashboard', notice: 'Account already activated or invalid activation link.')
    end
  end
end