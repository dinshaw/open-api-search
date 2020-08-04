Rails.application.routes.draw do
  namespace :v1 do
    post '/auth/login', to: 'authentication#login', as: :login
    get '/books', to: 'books#index'
    resources :searches
  end
end
