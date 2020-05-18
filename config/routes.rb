Rails.application.routes.draw do
  resources :meetings
  devise_for :users, :controllers => { registrations: 'registrations' }

  root 'meetings#index'
end
