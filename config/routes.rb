Rails.application.routes.draw do
  resources :lending_sets
  resources :lending_statuses
  resources :customers
  resources :customers, except: %w[new] do
    collection { post :bulk_insert }
  end
  resources :book_stocks
  resources :book_stocks, except: %w[new] do
    collection { post :bulk_insert }
  end
  resources :book_stock_statuses
  resources :authors
  resources :authors, except: %w[new] do
    collection { post :bulk_insert }
  end
  resources :book_masters
  resources :book_masters, except: %w[new] do
    collection { post :bulk_insert }
  end
  resources :ndc_categories
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
