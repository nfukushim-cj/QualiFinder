Rails.application.routes.draw do

  get 'draft/index'
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    get 'users', to: 'users#index'
    resources :users, only: [:edit, :show, :destroy, :update]
    resources :genres, only: [:edit, :new, :index, :update, :create, :destroy]
  end

  scope module: :public do
    devise_for :users
    root to: 'homes#top'
    get 'about' => 'homes#about'
    resources :users, only: [:show, :edit, :update, :destroy] do
      resource :follows, only: [:create, :destroy]
    end
    resources :follows, only:[:index]
    resources :posts, only: [:index, :show, :edit, :new, :create, :destroy, :update]
    resources :draft, only: [:index]
    get '/draft', to: 'public/draft#index', as: 'draft'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
