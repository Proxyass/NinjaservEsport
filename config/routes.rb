Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root  'home#index'

  ## Teams
  resources :teams
  # -------------

  ## Users
  resources :users
  # -------------

  ## Sessions
  get     'login'                          => 'sessions#new'
  post    'login'                          => 'sessions#create'
  delete  'logout'                         => 'sessions#destroy'
  # -------------
end
