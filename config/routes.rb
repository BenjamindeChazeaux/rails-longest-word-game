Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # Route pour accéder à l'action new via /new
  get '/new', to: 'games#new', as: :new_game

  # Modifier la route score pour qu'elle ne nécessite pas d'ID
  post '/score', to: 'games#score', as: :score_game

  # Routes pour le jeu de mots
  resources :games, only: [:new] do
    collection do
      post :score  # Déplacé dans collection car ne nécessite pas d'ID
    end
  end

  # Définir la page d'accueil
  root 'games#new'
end
