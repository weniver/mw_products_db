class ProductsController < ApplicationController
  def index
    @products = current_brand.products.paginate(page: params[:page])
  end

  def new
    @product = Product.new
    @product.categories.build
  end

  def create
    @product = current_brand.products.build(product_params)
    #saves both the product and the categories
    if @user.save
      @user.send_activation_email
      flash[:info] = "Por favor checa tu email para activar tu cuenta."
      redirect_to root_url
    else
      render 'new'
    end
  end
  #
  # def destroy
  #   User.find(params[:id]).destroy
  #   flash[:success] = "User deleted"
  #   redirect_to users_url
  # end
  #
  # def show
  #   @user = User.find(params[:id])
  # end
  #
  # def edit
  # end
  #
  # def update
  #   if @user.update_attributes(user_params)
  #     flash[:success] = "Tu perfil ha sido actualizado"
  #     redirect_to @user
  #   else
  #     render 'edit'
  #   end
  # end

  private

    def product_params
      params.require(:product).permit(:name,
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
