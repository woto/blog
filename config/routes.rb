ActionController::Routing::Routes.draw do |map|
  map.resources :comments

  #map.filter '/browse/*params', :controller => 'posts', :action => 'index'
  #map.resources :posts

  map.resources :categories, :collection => {:render_categories => :post}
  map.resources :posts, :collection => {:search => [:get], :sphinx => [:get]}

  map.root :posts
  
  #TODO заменить на member, или может вообще восстановить свой метод, чтобы
  # теги автозаполнялись только с первой буквы, а не искались все вхождения символа
  # в назание тега
  map.connect 'tags/auto_complete_for_tag_name', :controller => 'tags', :action => 'auto_complete_for_tag_name', :format => 'json'

  map.resources :captcha_tests

  map.register 'register', :controller => 'users', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.addrpxauth "addrpxauth", :controller => "users", :action => "addrpxauth", :method => :post
  map.resources :password_resets
  map.resource :user
  map.resource :user_session
 
  map.about_me 'about_me', :controller => 'about_me', :action => 'index'
  map.feedback 'feedback', :controller => 'feedback', :action => 'index'
  
  map.connect 'calendar', :controller => 'calendar'

  #map.resources :password_resets
  #map.resources :users
  #map.root :controller => "user_sessions", :action => "new"

  #map.register '/register/:activation_code', :controller => 'activations', :action => 'new'
  #map.activate '/activate/:id', :controller => 'activations', :action => 'create'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
