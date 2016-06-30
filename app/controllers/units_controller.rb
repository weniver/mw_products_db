class UnitsController < ApplicationController
  def index
    @units = Unit.all
  end

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
end
