Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :questions do
    collection do
      get :autocomplete
    end

    resources :answers
  end

  root to: 'questions#index'
end
