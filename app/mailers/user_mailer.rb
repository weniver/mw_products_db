class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: @user.email, subject: "Activa tu Cuenta"
  end

  def password_reset(user)
    @user = user
    mail to: @user.email, subject: "Cambia tu Contraseña"
  end
end
