module SessionsHelper
  #Logs in the User
  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  #Returns Current User Logged-in
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def current_brand
    @current_brand ||= current_user.brands.first
  end

  #Return TRUE if a user is logged_in
  def logged_in?
    !current_user.nil?
  end

  #Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  #Returns true if the given products brand is the current brand.
  def correct_brand_for_product?(product)
    product.brand == current_brand
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    if session[:forwarding_url] == login_path
      redirect_to(root_url)
    else
      redirect_to(session[:forwarding_url] || default)
    end
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end
