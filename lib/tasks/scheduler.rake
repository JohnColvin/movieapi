task :expire_cache => :environment do
  Pathname.new(ActionController::Base.page_cache_directory).join('movies').each_child do |file|
    file.unlink if file.mtime < 1.day.ago
  end
end