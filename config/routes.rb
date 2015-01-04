Rails.application.routes.draw do
  root 'welcome#index'

  resources :news_items
  resources :sites
  resources :users

  get ':controller(/:action(/:id))'
end
