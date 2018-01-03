Rails.application.routes.draw do
  get 'rooms/show'
  mount ActionCable.server => '/cable'
  devise_for :users,path_names: {sign_in:'login',sign_out:'logout',sign_up:'register'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
resources :restaurants, only: [:index, :show] do
  resources :comments, only: [:create, :destroy]
  collection do
    get :feeds
    get :ranking
  end
  member do
    get :dashboard
    post :favorite
    post :unfavorite
    post :like
    post :unlike
  end
end
resources :categories, only: :show

resources :users, only: [:index, :update, :show, :edit] do
  member do
    get :friend_list
  end
end


resources :followships, only: [:create, :destroy]

resources :friendships, only: [:create, :destroy]

root "restaurants#index"
namespace :admin do
    root "restaurants#index"
    resources :restaurants
    resources :categories 
  end



end
