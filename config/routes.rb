Movieapi::Application.routes.draw do

  match 'movies/top'

  resources :movies, only: [:index, :show]

end
