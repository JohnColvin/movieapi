task :expire_cache => :environment do
  Pathname.new(ActionController::Base.page_cache_directory).join('movies').each_child do |file|
    file.unlink if file.mtime < 1.day.ago
  end
end

task :cache_top_250 => :environment do
  refresh_needed = false

  %w{ xml json }.each do |file_ext|
    file_path = top_250_cache_file_path(file_ext)
    if !File.exists?(file_path) || File.new(file_path, 'r').mtime < 23.hours.ago
      refresh_needed = true
      break
    end
  end

  if refresh_needed
    top_250_movies = Movie.top_250
    %w{ xml json }.each do |file_ext|
      File.open(top_250_cache_file_path(file_ext), 'w') { |f| f.write(top_250_movies.send("to_#{file_ext}")) }
    end
  end
end

def top_250_cache_file_path(extenstion)
  File.join(ActionController::Base.page_cache_directory, 'movies', "top.#{extenstion}")
end