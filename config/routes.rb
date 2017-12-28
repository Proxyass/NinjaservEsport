Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root  'home#index'

  ## Teams
  resources :teams, only: [:index, :show]
  # -------------

  ## Users
  resources :users
  # -------------

  ## Administration area
  namespace :admin do
    resources :teams, except: [:show]
  end
  # -------------

  ## Sessions
  get     'login'                          => 'sessions#new'
  post    'login'                          => 'sessions#create'
  delete  'logout'                         => 'sessions#destroy'
  # -------------
end
