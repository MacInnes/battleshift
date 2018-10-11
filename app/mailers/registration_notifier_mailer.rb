class RegistrationNotifierMailer < ApplicationMailer

  def register(user)
    @user = user
    mail(to: user.email, subject: "BattleShift Registration")
  end

end
