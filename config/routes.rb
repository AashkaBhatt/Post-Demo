Rails.application.routes.draw do
  resources :posts do
    get "react_post"
    collection do
      get "react_comment"
      post "create_comment"
    end
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "posts#index"
end
