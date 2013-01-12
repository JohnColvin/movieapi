Movieapi::Application.routes.draw do

  match 'movies/top'
  match 'movies/:id' => 'movies#show', constraints: { id: /tt\d*/ }
  match 'movies/:term' => 'movies#index'

end
