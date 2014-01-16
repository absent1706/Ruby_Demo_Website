DemoApp::Application.routes.draw do
  root to:'static_pages#home'

  resources :microposts
  resources :users
  resources :sessions, only: [:new, :create, :destroy]


  match '/home', to: 'static_pages#home'
  match '/help', to: 'static_pages#help'
  match '/about', to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'

  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
end
