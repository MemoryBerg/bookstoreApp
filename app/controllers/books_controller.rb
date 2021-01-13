# frozen_string_literal: true
class BooksController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "admin",
                               except: [:index, :show, :add_to_cart, :remove_from_cart, :find_by_genre, :check_user]

  before_action :initialize_session
  before_action :increment_visit_count, only: %i[index]
  before_action :load_cart

  def index
    if params[:genre]
      @books = Book.find_by_sql ['SELECT * FROM books WHERE genre = ? and books.count > 0', params[:genre]]
    else
    @books = Book.where('count > 0')
    end
    unless $user
      $user = User.find(params[:id])
    end

    if !params[:id]
    elsif params[:id] != $user[:id]
      $user = User.find(params[:id])
    end
    @role = $user[:role] == 'admin'

  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book
    else
      render 'new'
    end
  end

  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      redirect_to @book
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    redirect_to books_path
  end

  def add_to_cart
    id = params[:id].to_i
    session[:cart] << id unless session[:cart].include?(id)
    redirect_to books_path
  end

  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_to books_path
  end

  def check_user
    @current_user = User.find_by_email(params[:book][:email])
    session[:user] = @current_user
    if @current_user
      session[:cart] = []
      redirect_to controller: 'books', action: 'index', :id => @current_user
    else
      flash[:danger] = 'Wrong email'
    end
  end

  def clear_cart
    session[:cart] = []
    $cart_sum = 0
    redirect_to controller: :orders, action: :got_order
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :genre, :description, :book_id, :price, :count)
  end

  def initialize_session
    session[:user] = ''
    session[:visit_count] ||= 0
    session[:cart] ||= []
    $cart_sum = 0
  end

  def load_cart
    @cart = Book.find(session[:cart])
  end

  def increment_visit_count
    session[:visit_count] += 1
    @visit_count = session[:visit_count]
  end

end
