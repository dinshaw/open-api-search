Rails.application.routes.draw do
  get '/books', to: 'books#index'
  resources :searches
end
