class OrdersController < ApplicationController

  def index
    if params[:status]
        @orders = Order.find_by_sql ['SELECT * FROM orders WHERE status = ?', params[:status]]
    else
      @orders = Order.all
    end
    @orders = @orders.sort_by {|ord| ord[:status]}
    @books_in_order = []
  end

  def new

  end
  def create
    @books = []
    params[:books].each do |book|
      @book = Book.find(book.to_i)
      if @book[:count] >= 1
        @book[:count] -= 1
        @book.save
        @books << @book[:id]
      end
    end
    @order = Order.new({ order: @books, user_id: $user[:id], status: 'In progress' })

    if @order.save
    redirect_to controller: :books, action: :clear_cart
    end
  end

  def show

  end

  def patch
  end

  def destroy
  end

  def got_order

  end

  def done
    @order = Order.find(params[:id])
    @order.update(status: 'Delivered')
    redirect_to action: :index
  end

end
