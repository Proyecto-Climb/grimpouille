Rails.application.routes.draw do
  devise_for :users
  root to: 'routes#select_project'

  get '/recommendations', to: 'routes#recommendations'
  namespace :admin do
    get '/dashboard', to: 'dashboard#index', as: '/'
    get '/dashboard/:id', to: 'dashboard#show', as: :route
    get '/dashboard/:id/edit', to: 'dashboard#edit', as: :edit_route
    patch '/dashboard/:id', to: 'dashboard#update', as: :update_route
  end
end
