Rails.application.routes.draw do
  
  root "public/restaurants#top"
  get 'about' => "public/homes#about"
  # 顧客用
# URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions',
  passwords: 'customers/passwords'
}
  #ゲストログイン用
  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'customers/sessions#guest_sign_in'
  end
  
  

  # 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
  
  
  get "search" => "searches#search"
  get "search_result" => "searchs#seach_result"
  resources :searches, only: :index


  get 'admin/customers' => 'admin/customers#index'
  scope module: :public do
  get 'customers/unsubscribe' => 'customers#unsubscribe'
  patch 'customers/withdraw' => 'customers#withdraw'
  get 'customers/my_page' => 'customers#show'
  get 'customers/my_page/restaurants' => 'customers#restaurants'
  get 'customers/my_page/reviews' => 'customers#reviews'
  resources :customers, only: [:edit, :update]
  end
  namespace :admin do
    resources :customers, only: [:show, :edit, :update]
  end
  
  scope module: :public do
    patch 'restaurants/:id' => 'restaurants#update', as: 'update_restaurant'
    resources :restaurants, except: [:update] do
        resources :reviews, only: [:create, :destroy]
    end
  end
  namespace :admin do
    post 'restaurants/new' => 'restaurants#create'
    get 'restaurants' => 'restaurants#index'
    resources :restaurants, except: [:create, :index]
  end
  
  scope module: :public do
    resources :reviews, only: [:index, :edit, :update, :destroy]
  end
  namespace :admin do
    resources :reviews, only: [:new, :index, :show, :edit, :update, :destroy]
  end
  
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
