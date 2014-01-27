DemoApp::Application.routes.draw do
  root to:'static_pages#home'

  
  resources :users do
    member {get :following, :followers}
  end

  resources :microposts, only: [:create, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :relationships, only: [:create, :destroy]

  match '/home', to: 'static_pages#home'
  match '/help', to: 'static_pages#help'
  match '/about', to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'

  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  get  '/reset_password', to: 'reset_passwords#new'
  post '/reset_password', to: 'reset_passwords#create'
  put '/reset_password(.:reset_password_token)', to: 'reset_passwords#update'
  get '/edit_new_password(.:reset_password_token)', to: 'reset_passwords#edit', as: :edit_new_password
end
