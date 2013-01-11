class Movie

  include ActiveModel::Serializers::JSON
  include ActiveModel::Serializers::Xml

  require 'open-uri'

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
    title_and_release_year.gsub(/[\s]+\([\d]+\)/, '').strip
  end

  def release_year
    title_and_release_year.match(/[\s]+\(([\d]+)\)/)
    $1
  end

  def rating
    rating_container = overview.at_css('div[itemprop="aggregateRating"] .star-box-giga-star')
    rating_container ? rating_container.text.strip : nil
  end

  def self.search(term=nil)
    results = []
    if term.present?
      results_doc = Nokogiri::HTML(open("http://www.imdb.com/find?s=tt&q=#{term}"))
      results_doc.at_css('table.findList').children.each do |result|
        result.at_css('td.result_text a').attribute('href').to_s.match(/(tt[\d]+)/)
        results << Movie.new($1)
        break if results.size == RESULT_LIMIT
      end
    end
    results
  end

  private

  def doc
    @doc ||= Nokogiri::HTML(open("http://www.imdb.com/title/#{@id}"))
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

end