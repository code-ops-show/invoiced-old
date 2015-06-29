Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  resources :invoices
  resources :customers do
    get   'scope/:scope',   to: 'customers#index',  as: :scope,   on: :collection
    match 'case/:case',     to: 'customers#update', as: :case,   on: :member, via: [:put, :patch]
    get   'notify/:notify', to: 'customers#show',   as: :notify, on: :member
    resources :invoices
  end
  # You can have the root of your site routed with "root"
  root 'customers#index'
  # root 'users#sign_in'

end
