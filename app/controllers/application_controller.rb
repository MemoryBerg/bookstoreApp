class ApplicationController < ActionController::Base

  def current_cart
    @current_cart ||= begin
                        Cart.find_or_create_by(user: @user)
                      end
  end

  def cart_items
    current_cart.cart_items
  end

  helper_method :current_cart, :cart_items

end
