Rails.application.routes.draw do
  
  match '/*path' => 'application#cors_preflight_check', :via => :options
  resources :users, only: [] do 
    post 'authenticate'
  end
 
end
