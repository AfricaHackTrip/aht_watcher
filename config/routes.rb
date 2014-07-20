Rails.application.routes.draw do
  root 'videos#index'
  resources :videos do
    collection do
      get :all
    end
  end
  get '/tags/:tag' => 'videos#search', as: 'tag'
end
