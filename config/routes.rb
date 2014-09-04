Rails.application.routes.draw do
  root 'videos#index'
  resources :videos do
    collection do
      get :all
      get :phase1
    end
    member do
      get :show_phase1
    end
  end
  get '/tags/:tag' => 'videos#search', as: 'tag'
end
