Rails.application.routes.draw do

  root 'pages#index'

  resources :rooms do
    resources :messages
  end

  resources :boards
  resources :pins do
    resources :comments
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
