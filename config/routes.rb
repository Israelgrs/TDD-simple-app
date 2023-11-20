Rails.application.routes.draw do
  devise_for :members, controllers: { sessions: 'members/sessions' }
  resources :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
