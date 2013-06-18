Wido2::Application.routes.draw do
  namespace :workspace do
    root to: "main#root"

    match "inbox" => "main#inbox"
    
    resources :links do
      get "bookmarklet", on: :collection
    end
  end
end
