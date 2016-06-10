module SessionsHelper
  #Logs in the User
  def log_in(user)
    session[:user_id] = user.id
  end

  #Returns Current User Logged-in
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  #Return TRUE if a user is logged_in
  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
