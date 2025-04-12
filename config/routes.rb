Rails.application.routes.draw do
  resources :books do 
    post '/borrow', to: 'books#borrow_book', on: :member
    post '/return', to: 'books#return_book', on: :member
  end

  post '/borrowed_books', to: 'books#borrowed_books_list'
  get "up" => "rails/health#show", as: :rails_health_check
end
