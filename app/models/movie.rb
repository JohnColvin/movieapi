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
    rows_to_movies(imdb_search_result_rows(term), 'td.result_text a')
  end

  def self.top_250(page)
    offset = (page - 1) * RESULT_LIMIT
    rows_to_movies(imdb_top_250_rows(offset), 'td a')
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
    get_document("http://www.imdb.com/find?s=tt&q=#{term}").at_css('table.findList').children[0..(RESULT_LIMIT-1)]
  end

  def self.imdb_top_250_rows(offset)
    rows = []
    top_table = Movie.get_document('http://www.imdb.com/chart/top').css('div#main table')[1]
    top_table.children.each_with_index do |row, index|
      next if index <= offset
      next if offset == 0 && index == 0 #skip header row
      rows << row
      break if rows.size == RESULT_LIMIT
    end
    rows
  end

  def self.build_from_anchor_tag(anchor_tag)
    anchor_tag.attribute('href').to_s.match(/(tt[\d]+)/)
    Movie.new($1)
  end

  require 'open-uri'
  def self.get_document(url)
    Nokogiri::HTML open(url)
  end

  def self.rows_to_movies(rows, anchor_selector)
    rows.map { |row| Movie.build_from_anchor_tag(row.at_css(anchor_selector)) }
  end

end