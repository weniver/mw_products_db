class UsersController < ApplicationController
  skip_before_action :logged_in_user, only: [:new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  #Initialize User and brand for the nested form.
  def new
    @user = User.new
    @user.brands.build
  end

  def create
    @user = User.new(user_params)
    #saves both the user and the brand name
    if @user.save
      @user.send_activation_email
      flash[:info] = "Por favor checa tu email para activar tu cuenta."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Tu usuario ha sido actualizado"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name,
                                   :email,
                                   :password,
                                   :password_confirmation,
                                    brands_attributes: [:id, :name])
    end

    # Before filters

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms the correct user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
