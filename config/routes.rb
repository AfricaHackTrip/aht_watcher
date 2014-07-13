Rails.application.routes.draw do
  root 'videos#index'
  resources :videos
  get '/tags/:tag' => 'videos#search', as: 'tag'
end
