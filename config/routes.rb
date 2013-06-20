Wido2::Application.routes.draw do
  namespace :workspace do
    root to: "main#root"

    concern :linkable do
      resources :links, constraints: { id: /\d+/ } do
        get "bookmarklet", on: :collection
      end
    end

    # resources :lists, concerns: :linkable
    resources :collations, path: '', only: :show, constraints: { id: /(inbox|review)/ } do
      concerns :linkable
    end

  end
end
