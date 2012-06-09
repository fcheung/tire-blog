TireBlog::Application.routes.draw do
  resources :posts do
    collection do
      get :search
    end
  end
  root :to => 'posts#index'
end
