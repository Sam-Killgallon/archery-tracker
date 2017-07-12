Rails.application.routes.draw do
  root 'rounds#index'
  get '/rounds', to: 'rounds#index'
end
