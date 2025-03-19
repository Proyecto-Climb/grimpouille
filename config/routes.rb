Rails.application.routes.draw do
  devise_for :users
  root to: 'routes#home'

  get '/recommendations', to: 'routes#recommendations'
end
