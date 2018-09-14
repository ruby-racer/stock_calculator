Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :stocks
  get 'welcome/home'
  devise_for :users
  root to: "welcome#home"
end
