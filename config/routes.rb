Wido2::Application.routes.draw do
  get "bundles/show"
  get "articles/show"
  devise_for :users, controllers: { sessions: "users/sessions", 
                                    :omniauth_callbacks => "users/omniauth_callbacks" }

  root to: "main#root"

  namespace :workspace do
    root to: "main#root"


    concern :linkable do
      resources :links, constraints: { id: /\d+/ } do
        get "bookmarklet", on: :collection
      end
      
      resources :articles, constraints: { id: /\d+/ }
    end

    scope "bookmarklets", as: 'bookmarklet', controller: 'bookmarklets' do
      get "add_link"
    end

    resources :collations, path: '', only: :show, constraints: { id: /(inbox|review)/ } do
      concerns :linkable
    end

    resources :lists, concerns: :linkable

    resources :articles do
      resources :attachments
    end
  end

  resources :bundles
  get "/atom" => "main#atom"
  get "/:author/:article" => "articles#show", as: "pattern_article"
end
