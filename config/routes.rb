Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :actions do
    collection do
      get 'search_twitter_user'
    end
  end
end
