class UsersController < ApplicationController
  def index
    @all_users = User.where("orders > 0", role: "user")
  end

  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def create
    params[:user][:role] = 'user' if params[:user][:user].to_i == 1
    params[:user][:orders] = 0
    exist_user = User.find_by_email(params[:user][:email])
    if exist_user
      # render 'edit'
      puts 'email exist'
      #alert user about error
    else
      @user = User.new(params.require(:user).permit(:firstname, :lastname, :email, :status, :orders, :role, :address))
      @user.save

      @cart = Cart.new(:user_id => @user.id)
      @cart.save

      redirect_to @user
      # render plain: params[:user].inspect
    end
  end

  # def get_all_users
  #   @all_users = User.where("orders > 0")
  #   puts @all_users
  # end
end
