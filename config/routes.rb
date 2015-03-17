Rails.application.routes.draw do
  resources :notes

  resources :messages

  resources :offices

  devise_for :users

  resources :users

  get '/' => 'messages#index'
  get '/manage' => 'users#index'
  get '/compose' => 'messages#new'
  get '/view/:id' => 'messages#show'
  get '/department' => 'functions#show'
  get '/sent' => 'messages#sent'
  get 'users/:id/disable' => 'users#disable', :as => 'disable_user'
  get 'users/:id/restore' => 'users#restore', :as => 'restore_user'
  get 'users/:id/terminate' => 'users#terminate', :as => 'terminate_user'
  get 'messages/:id/history' => 'messages#history', :as => 'message_history'
  match 'messages/:id/reply' => 'messages#reply', :as => 'reply_message', via: [:get, :post]
  get 'messages/:id/close' => 'messages#close', :as => 'close_message'
  get 'messages/:id/unclose' => 'messages#unclose', :as => 'unclose_message'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
