Rails.application.routes.draw do
  resources :users do
    collection { post :import }
    get 'export' , to: 'users#export'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "users#index"
end
