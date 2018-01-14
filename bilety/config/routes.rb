Rails.application.routes.draw do
  get 'events/index'

  get 'events/:id' => 'events#show'

  get 'events/new'

  get 'events/create'

  resources :tickets
  root :to  => "tickets#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
