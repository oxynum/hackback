Rails.application.routes.draw do
  
  match '/*path' => 'application#cors_preflight_check', :via => :options
  resources :users, only: [] do 
    post 'authenticate'
  end

  resources :movies, :series, :animes, only: :index do 
    collection do
      get 'updated_at'
    end
  end

end
