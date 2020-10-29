# frozen_string_literal: true

Rails.application.routes.draw do
  if Rails.env.production?
    mount BlogEngine::Engine, at: '/', constraints: { subdomain: 'blog' }
    mount Sports::Engine, at: '/', constraints: { subdomain: 'sports' }
  else
    mount BlogEngine::Engine, at: '/blog'
    mount Sports::Engine, at: '/sports'
  end

  match 'account' => 'account#login', via: %i[get post]
  get 'account/index'
  get 'account/login' => 'account#login'
  post 'account/login'
  get 'account/logout'
  match 'account/signup', via: %i[get post]

  get 'icon/:width(x:height)' => 'icons#inline'

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
