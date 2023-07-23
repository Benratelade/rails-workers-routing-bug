Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get 'rendering/direct', to: 'rendering#direct', as: :direct_rendering
  get 'rendering/async', to: 'rendering#async', as: :async_rendering
  resources :rich_text_examples, only: %w[new create show]
end
