class Movie

  include ActiveModel::Serializers::JSON
  include ActiveModel::Serializers::Xml

  RESULT_LIMIT = 10

  def initialize(imdb_id)
    @id = imdb_id
    self
  end

  def serializable_hash(options={})
    options[:methods] = %w{ title release_year rating }
    super(options)
  end

  def attributes
    {}
  end

  def title
    title_and_release_year.gsub(/[\s]+\(.+\)/, '').strip
  end

  def release_year
    title_and_release_year.match(/[\s]+\(\D*(\d+)\D*\)/)
    $1
  end

  def rating
    rating_container = overview.at_css('div[itemprop="aggregateRating"] .star-box-giga-star')
    rating_container ? rating_container.text.strip : nil
  end

  def self.search(term=nil)
    results = []
    if term.present?
      imdb_search_result_rows(term).each do |row|
        imdb_path = row.at_css('td.result_text a').attribute('href').to_s
        results << Movie.build_from_path(imdb_path)
        break if results.size == RESULT_LIMIT
      end
    end
    results
  end

  private

  def doc
    @doc ||= self.class.get_document("http://www.imdb.com/title/#{@id}")
  end

  def content
    @content ||= doc.at_css('#pagecontent')
  end

  def overview
    @overview ||= content.at_css('#overview-top')
  end

  def title_and_release_year
    @tary ||= overview.at_css('h1.header').text
  end

  def self.imdb_search_result_rows(term)
    get_document("http://www.imdb.com/find?s=tt&q=#{term}").at_css('table.findList').children
  end

  def self.build_from_path(path)
    path.match(/(tt[\d]+)/)
    Movie.new($1)
  end

  require 'open-uri'
  def self.get_document(url)
    Nokogiri::HTML open(url)
  end

end