Wido2::Application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }
  root to: "main#root"

  namespace :workspace do
    root to: "main#root"

    concern :linkable do
      resources :links, constraints: { id: /\d+/ } do
        get "bookmarklet", on: :collection
      end
    end

    scope "bookmarklets", as: 'bookmarklet', controller: 'bookmarklets' do
      get "add_link"
    end

    # resources :lists, concerns: :linkable
    resources :collations, path: '', only: :show, constraints: { id: /(inbox|review)/ } do
      concerns :linkable
    end

  end
end
