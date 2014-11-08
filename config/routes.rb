Rails.application.routes.draw do

  resources :users, only: [] do 
    get 'authenticate'
  end
 
end
