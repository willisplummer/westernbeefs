Rails.application.routes.draw do
  resources :articles, except: [:show, :update, :destroy] do
    resources :stories
    resources :pages, except: [:show, :update, :destroy]
  end

  resources :stories do
    resources :pages, except: [:show, :update, :destroy]
  end

  get '/admin' => 'articles#admin_index', as: :admin_index
  get '/:id/' => 'articles#show', as: :article
  get '/:id/admin' => 'articles#admin', as: :article_admin
  get '/:id/bio' => 'articles#bio', as: :article_bio
  match '/:id/' => 'articles#update', via: [:patch, :put], as: :article_update
  delete '/:id/' => 'articles#destroy', via: :delete, as: :article_delete

  get '/:article_id/:id' => 'pages#show', as: :article_page
  match '/:article_id/:id' => 'pages#update', via: [:patch, :put], as: :article_page_update
  delete '/:article_id/:id' => 'pages#destroy', via: :delete, as: :article_page_delete

  #get '/:article_id/:story_id/:id' => 'pages#show', as: :story_page
  #match '/:article_id/:story_id/:id' => 'storypages#update', via: [:patch, :put], as: :story_page_update
  #delete '/:article_id/:story_id/:id' => 'storypages#destroy', via: :delete, as: :story_page_delete

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'articles#index'

  # Example of regular route:
#  get '/:author_slug/' => 'articles#show', as: :custom_article

#  get '/:author_slug/:page_number/' => 'pages#show', as: :custom_page

  # Example of named route that can be invoked with purchase_url(id: product.id)

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
