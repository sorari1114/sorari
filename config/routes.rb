Rails.application.routes.draw do
  devise_for :users
  get "foods/top" => "foods#top"
  resources :users, only: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :foods do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
    
  end
  resources :perfumes
  
  root 'foods#top'
end
