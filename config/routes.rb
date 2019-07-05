Rails.application.routes.draw do
  if Rails.env.production?
    mount Sports::Engine, at: '/', constraints: { domain: 'sports.kubosch.no' }
  else
    mount Sports::Engine, at: '/sports'
  end

  root 'welcome#index'

  get 'account/index'
  post 'account/login'
  get 'account/logout'
  match 'account/signup', via: [:get, :post]

  resources :news_items do
    collection { get :list }
  end
  resources :sites do
    collection { get :list }
  end

  get 'status' => 'status#index'

  resources :users
end
