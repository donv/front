Rails.application.routes.draw do
  if Rails.env.production?
    mount Sports::Engine, at: '/', constraints: { subdomain: 'sports' }
  else
    mount Sports::Engine, at: '/sports'
  end

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

  root 'welcome#index'
end
