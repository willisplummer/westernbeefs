Rails.application.routes.draw do
    resources :articles, except: [:show, :update, :destroy] do
      resources :pages, except: [:show, :update, :destroy] # (this part is also still broken)
    end

  get '/:id/' => 'articles#show', as: :article
  match '/:id/' => 'articles#update', via: [:patch, :put], as: :article_update
  delete '/:id/' => 'articles#destroy', via: :delete, as: :article_delete

# almost got everything to work, but this next part still breaks everything ¯\_(ツ)_/¯

  get '/:article_id/:id' => 'pages#show', as: :article_page
  match '/:article_id/:id' => 'pages#update', via: [:patch, :put], as: :article_page_update
  delete '/:article_id/:id' => 'pages#destroy', via: :delete, as: :article_page_delete

#  put '/:id/' => 'articles#update', as: :article_update
#  patch '/:id/' => 'articles#update', as: :article_update
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
