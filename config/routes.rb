Rails.application.routes.draw do
  get 'privacypolicy', to: 'static#privacypolicy'
  get 'term', to: 'static#term'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks'}
  root 'home#index'

  resources :maps, :only => [:new,:create,:edit,:update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
