= Movie API

==== This app is a proof of concept and is not intended for use. Consult IMDB's terms before screen scraping them.

This app performs on demand (no caching) screen scraping of IMDB. All responses are availavle in JSON and XML formats.

== Endpoints

=== Movie Details

Returns the movie with the provided IMDB ID (ex: tt1049413)

Path: /movies/:imdb_id.format

Example: /movies/tt1049413.json

=== Movie Search

Returns the first 10 results that match your search query

Path: /movies.xml?term=:search_term

Example: /movies.json?term=up

=== Top 250

Returns the IMDB top 250 in 25 pages with 10 results per page. (Since there is no caching, returning all results in one response takes a very long time)
Page numbers range from 1 to 25 inclusive. Passing no page number will return the first 10 results.

Path: /movies/top.json?page=:page_number

Example: movies/top.json?page=2
