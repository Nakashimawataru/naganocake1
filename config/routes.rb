Rails.application.routes.draw do
  root to: "public/homes#top"
  get "home/about" => "public/homes#about", as: "about"
     get "admin" => "admin/homes#top", as: "admin"
 # 顧客用
# URL /customers/sign_in ...


# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  namespace :admin do
   resources :items, only: [:index, :show,  :create, :new, :edit, :update]

   resources :customers, only:[:index, :show, :edit, :update]

   resources :orders, only:[:show]
  end

  scope module: :public do
    resources :items, only: [:index, :show]
      patch "customers" => "customers#update"
      get "customers/edit" => "customers#edit"
      get "customers/show" => "customers#show"
      get "customers/cancellation" => "customers#cancellation"
      patch "customers/withdrawal" => "customers#withdrawal"
      delete "cart_items/destroy_all" => "cart_items#destroy_all"
    resources :cart_items, only: [:index, :update, :destroy, :create]
      get "orders/completion" => "orders#completion"
    resources :orders, only: [:new, :create, :index, :show]
      post "orders/confirm" => "orders#confirm"

  devise_for :customers, controllers: {
   registrations: "public/registrations",
    sessions: 'public/sessions'
    }

  end
end
