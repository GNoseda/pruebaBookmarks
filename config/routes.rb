Rails.application.routes.draw do
  resources :bookmarks
  resources :categories
  resources :kinds
  root "bookmarks#index"

  post 'categories/:id/change' , to: 'categories#change', as: 'change'
  get 'api/categories/:id' , to: 'categories#api', as: 'api'
  get '/stats', to: 'bookmarks#stats', as: 'stats'
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
