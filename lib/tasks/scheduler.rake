namespace :cache do

  task :top_250 => :environment do
    top_250_movies = Movie.top_250

    cache = Dalli::Client.new

    %w{ xml json }.each do |file_ext|
      cache.set("views/movieapi.herokuapp.com/movies/top.#{file_ext}", top_250_movies.send("to_#{file_ext}"), 172800)
    end
  end
end