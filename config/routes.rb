Movieapi::Application.routes.draw do

  match 'movies/top250'
  match 'movies/best-pictures' => 'movies#best_pictures'
  match 'movies/:id' => 'movies#show', constraints: { id: /tt\d*/ }
  match 'movies/:term' => 'movies#index'

end
