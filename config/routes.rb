Rails.application.routes.draw do
  devise_for :users
  root to: 'routes#select_project'

  get '/recommendations', to: 'routes#recommendations'
end
