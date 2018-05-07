Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root  'home#index'

  ## Teams
  resources :teams, only: [:index, :show]
  resources :games, only: [:index, :show]
  # -------------

  ## Users
  resources :users
  # -------------

  ## News
  resources :news, only: [:index, :show] , param: :slug
  # -------------

  ## Sponsors
  resources :sponsors, only: :index
  # -------------

  ## TinyMCE assets
  post '/tinymce_assets'                  => 'admin/tinymce_assets#create'
  # -------------

  ## Administration area
  namespace :admin do
    get    '/'                            => 'home#index'
    resources :teams, except: [:show] do
      get 'delete'
      resources :team_members, only: [:index, :new, :create,:delete, :destroy]
    end
    resources :games, except: [:show] do
      get 'delete'
    end
    resources :team_member_roles, except: [:show] do
      get 'delete'
    end
    resources :users do
      get 'delete'
      patch 'set_admin'
      patch 'unset_admin'
    end
    resources :news do
      get 'delete'
    end
    resources :sponsors do
      get 'delete'
    end
  end
  # -------------

  ## Static pages
  get     'about_us'                       => 'statics#about_us'
  # -------------

  ## Sessions
  get     'login'                          => 'sessions#new'
  post    'login'                          => 'sessions#create'
  delete  'logout'                         => 'sessions#destroy'
  # -------------
end
