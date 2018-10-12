class UserActivatorMailer < ApplicationMailer
  def activate(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Battleshift')
  end
end
