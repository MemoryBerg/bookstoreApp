class CheckoutController < ApplicationController
  def create
    @book = Book.find(params[:id])

    if @book.nil?
      redirect_to books_path
      return
    end

    respond_to do |format|
      format.js
    end

    redirect_to checkout_success_path
  end

  def success
    @user
  end

  def cancel

  end
end
