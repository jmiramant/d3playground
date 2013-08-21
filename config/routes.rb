Graph::Application.routes.draw do
  root :to => "users#index"
  get '/users/fitscore_match' => "users#fitscore_match"
  get '/users/company_match' => "users#company_match"
  get '/users/following_match' => "users#following_match"
  resources :users, only: [:new, :create]
end
