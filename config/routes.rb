Rails.application.routes.draw do
  

 

   root 'static_pages#home'

  # get 'session/new'

  # get 'static_pages/home'

  # get 'static_pages/help'

  # get 'static_pages/about'

  # get 'static_pages/contact'
  get 'question/new'
  get 'question/show'
  get 'users/new'
  get 'questions/all', to: 'question#show'
  get 'questions/new', to: 'question#new'
  post '/questions', to: 'question#create'
  get '/questions/:id', to:  'question#id'
  get '/vote', to: 'question#vote'
  resources :questions

  # get 'answer/new'
  get 'answers/new/:id', to: 'answer#new'
  post 'answers/new/:id', to: 'answer#create'
  get '/vote/answer', to: 'answer#vote'
  resources :answers

 
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'user#new'
  post '/signup',  to: 'user#create'
  get    '/login',   to: 'session#new'
  post   '/login',   to: 'session#create'
  get '/logout',  to: 'session#destroy'
  delete '/logout',  to: 'session#destroy'
  get '/users/:id', to:  'user#show'
  resources :users





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
  match ':controller(/:action(/:id))', :via => :get

end
