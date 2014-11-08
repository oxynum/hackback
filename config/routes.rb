Rails.application.routes.draw do

  resources :users, only: [] do 
    post 'authenticate'
  end
 
end
