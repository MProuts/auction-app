AuctionAppSecondGo::Application.routes.draw do
  # root
  root 'auctions#index'

  # users
  get "register" => "users#new"
  post "users/" => "users#create"

  get "users/new" => "users#new", :as => "new_user"
  get "users/:id/edit" => "users#edit", :as => "edit_user"

  patch "users/:id" => "users#update", :as => "user"
  delete "users/:id" => "users#destroy"

  # session
  post "sessions/" => "sessions#create"
  delete "sessions/:id" => "sessions#destroy", :as => "session"

  # auctions
  get "auctions/" => "auctions#index"
  post "auctions/" => "auctions#create"

  get "auctions/new" => "auctions#new", :as => "new_auction"
  get "auctions/:id/edit" => "auctions#edit", :as => "edit_auction"

  get "auctions/:id" => "auctions#show", :as => "auction"
  patch "auctions/:id" => "auctions#update"
  delete "auctions/:id" => "auctions#destroy"

  # bids
  post "auctions/:auction_id/bids/" => "bids#create", :as => "auction_bid"
  get "auctions/:auction_id/bids/new" => "bids#new", :as => "new_auction_bid"
  get "bids/:id" => "bids#show", :as => "bid"

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
