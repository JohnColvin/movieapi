# Movie API

#### This app is a proof of concept and is not intended for use. Consult IMDB's terms before screen scraping them.

This app screen scrapes IMDB for basic information. All responses are available in JSON and XML formats, except the top 250 which is only availble in JSON.

A demo of this app is running at [movieapi.herokuapp.com](http://movieapi.herokuapp.com). The root path goes nowhere, so use one of the endpoints described below.

## Endpoints

### Movie Details

Returns the movie with the provided IMDB ID (ex: tt1049413)

- Path: /movies/:imdb_id.:format
- Example: [/movies/tt1049413.json](http://movieapi.herokuapp.com/movies/tt1049413.json)

### Movie Search

Returns the first 10 results that match your search query

- Path: /movies/:term.:format
- Example: [/movies/up.json](http://movieapi.herokuapp.com/movies/up.json)

### Top 250

Returns the IMDB top 250 (only available in JSON format)

- Path: /movies/top250.:format
- Example: [/movies/top250.json](http://movieapi.herokuapp.com/movies/top250.json)

## Response data

<table>
  <thead>
    <tr>
      <th>Attribute</th>
      <th>Description</th>
      <th>Example</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>id</td>
      <td>IMDB ID</td>
      <td>tt1049413</td>
    </tr>
    <tr>
      <td>title</td>
      <td>Movie title</td>
      <td>Up</td>
    </tr>
    <tr>
      <td>release_year</td>
      <td>Film release year</td>
      <td>2009</td>
    </tr>
    <tr>
      <td>rating</td>
      <td>IMDB aggregate rating</td>
      <td>8.4</td>
    </tr>
    <tr>
      <td>storyline</td>
      <td>The storyline of the movie</td>
      <td>A movie about a boy and an old man going on a journey</td>
    </tr>
  </tbody>
</table>
