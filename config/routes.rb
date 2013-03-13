Wido2::Application.routes.draw do
  namespace :workspace do
    match "inbox" => "main#inbox"
    
    resources :links do
      get "bookmarklet", on: :collection
    end
    
  end
end
