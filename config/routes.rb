Rails.application.routes.draw do
  root 'welcome#index'

  get 'account/index'
  post 'account/login'
  get 'account/logout'
  match 'account/signup', via: [:get, :post]

  resources :news_items do
    collection {get :list}
  end
  resources :sites do
    collection {get :list}
  end
  resources :users
end
