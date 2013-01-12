# Movie API

#### This app is a proof of concept and is not intended for use. Consult IMDB's terms before screen scraping them.

This app screen scrapes IMDB for basic information. All responses are available in JSON and XML formats.

## Endpoints

### Movie Details

Returns the movie with the provided IMDB ID (ex: tt1049413)

- Path: /movies/:imdb_id.:format
- Example: /movies/tt1049413.json

### Movie Search

Returns the first 10 results that match your search query

- Path: /movies/:term.:format
- Example: /movies.up.json

### Top 250

Returns the IMDB top 250

- Path: /movies/top.:format
- Example: movies/top.json
