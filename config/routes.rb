Movieapi::Application.routes.draw do

  resources :movies, only: [:show]

end
