Rails.application.routes.draw do
  resources :users, only: [:show] do
    collection do
      post 'login'
    end

    resources :clock_entries do
      collection do
        get 'next'
      end
    end
  end
end
