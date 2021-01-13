# frozen_string_literal: true
Rails.application.routes.draw do
  get 'orders/index'
  get 'users/index'
  get 'welcome/index'
  get 'books/index'

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create', :defaults => { :format => 'js' }
    get 'cancel', to: 'checkout#cancel',  as: 'checkout_cancel'
    get 'success', to: 'checkout#success', as: 'checkout_success'

  end
  resources :books
  resources :users
  resources :orders

  get 'books/index/findByGenre', to: 'books#find_by_genre'
  get 'books/add_to_cart/:id', to: 'books#add_to_cart', as: 'add_to_cart'
  delete 'books/remove_from_cart/:id', to: 'books#remove_from_cart', as: 'remove_from_cart'
  post 'books/check_user', to: 'books#check_user', as: 'check_user'
  get 'books/index/clear_cart', to: 'books#clear_cart', as: 'clear_cart'
  get 'orders/index/got_order', to: 'orders#got_order', as: 'got_order'
  get 'orders/index/done/:id', to: 'orders#done', as: 'done'

  root 'welcome#index'

end
