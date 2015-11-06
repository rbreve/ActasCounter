ConteoActas::Application.routes.draw do
  resources :reportes, :except=>[:destroy, :edit, :update, :show, :new]
  resources :users, :except=>[:destroy, :new]
  resources :verifications, :except=>[:edit,:destroy,:update,:new]

  get "/acta/lista/:type", to: "acta#index", as: "acta_list"
  get "/acta/lista/:type/:id", to: "acta#show", as: "actum_type"
  
  resources :acta, :except=>[:edit,:update,:destroy]
  
  
  resources :user_profile
  
  get '/search' => 'acta#show'
  get '/acerca' => 'home#about'
  get '/contacto' => 'home#contacto'
  get 'all-done' => 'home#all_done', :as => :all_done
  
  devise_for :users, :path => "auth", :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
