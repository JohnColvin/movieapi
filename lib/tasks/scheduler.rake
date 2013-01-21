namespace :cache do

  task :top_250 => :environment do
    top_250_movies = Movie.top_250

    cache = Dalli::Client.new

    %w{ xml json }.each do |file_ext|
      cache.set("views/movieapi.herokuapp.com/movies/top250.#{file_ext}", top_250_movies.send("to_#{file_ext}"), 172800)
    end
  end

  task :best_pictures => :environment do
    best_pictures = Movie.best_picture_winners

    cache = Dalli::Client.new

    %w{ xml json }.each do |file_ext|
      cache.set("views/movieapi.herokuapp.com/movies/best-pictures.#{file_ext}", best_pictures.send("to_#{file_ext}"), 172800)
    end
  end
end
