Rails.application.routes.draw do
  root to: "public/homes#top"
  get "home/about" => "public/homes#about", as: "about"
 # 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions',
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  namespace :admin do
   resources :items, only: [:index, :show, :create, :show, :edit, :update]
   resources :homes, only:[:top]
   resources :customers, only:[:index, :show, :edit, :update]
   resources :orders, only:[:show]
  end

  scope module: :public do
    resources :items, only: [:index, :show]
    resources :customers, only: [:show, :edit, :update, :cancellation, :withdrawal]
    resources :cart_items, only: [:index, :update, :destroy, :destroy_all, :create]
    resources :orders, only: [:new, :confirm, :completion, :create, :index, :show]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
