Rails.application.routes.draw do
  resources :stocks
  get 'welcome/home'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "welcome#home"
end
