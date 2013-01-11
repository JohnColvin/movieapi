class Dom

  require 'open-uri'

  def self.get(url)
    Nokogiri::HTML open(url)
  end

end