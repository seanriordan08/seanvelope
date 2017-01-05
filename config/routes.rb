Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  resources :articles
  resources :questions, only: [:new, :create]

  get 'basin_metrics/dashboard' => 'basin_metrics/dashboard#index'

  get 'basin_metrics/maps' => 'basin_metrics/maps#index'

  get 'basin_metrics/customers' => 'basin_metrics/customers#index'
  get 'basin_metrics/customers/new' => 'basin_metrics/customers#new'
  post 'basin_metrics/customers' => 'basin_metrics/customers#create'
  put 'basin_metrics/customers/:id' => 'basin_metrics/customers#update'
  delete 'basin_metrics/customers/:id' => 'basin_metrics/customers#destroy', as: 'basin_metrics_customer_delete'

  get 'basin_metrics/districts' => 'basin_metrics/districts#index'
  get 'basin_metrics/districts/new' => 'basin_metrics/districts#new'
  post 'basin_metrics/districts' => 'basin_metrics/districts#create'
  put 'basin_metrics/districts/:id' => 'basin_metrics/districts#update'
  delete 'basin_metrics/districts/:id' => 'basin_metrics/districts#destroy', as: 'basin_metrics_district_delete'

  get 'basin_metrics/wells' => 'basin_metrics/wells#index'
  get 'basin_metrics/wells/new' => 'basin_metrics/wells#new'
  post 'basin_metrics/wells' => 'basin_metrics/wells#create'
  put 'basin_metrics/wells/:id' => 'basin_metrics/wells#update'
  get 'basin_metrics/wells/:id' => 'basin_metrics/wells#show', as: 'basin_metrics_well_show'
  delete 'basin_metrics/wells/:id' => 'basin_metrics/wells#destroy', as: 'basin_metrics_well_delete'

  get 'basin_metrics/parts' => 'basin_metrics/parts#index'
  get 'basin_metrics/parts/new' => 'basin_metrics/parts#new'
  post 'basin_metrics/parts' => 'basin_metrics/parts#create'
  put 'basin_metrics/parts/:id' => 'basin_metrics/parts#update'
  delete 'basin_metrics/parts/:id' => 'basin_metrics/parts#destroy', as: 'basin_metrics_part_delete'

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
