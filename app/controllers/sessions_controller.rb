class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or root_url
      else
        message = "Tu cuenta no se encuentra activa. Checa tu correo electrónico y da click en el link que te enviamos."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = '¡La convinación contraseña/correo electrónico es incorrecta!'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
