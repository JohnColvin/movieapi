class Movie

  include ActiveModel::Serializers::JSON
  include ActiveModel::Serializers::Xml

  RESULT_LIMIT = 10

  def initialize(imdb_id)
    @id = imdb_id
    self
  end

  def serializable_hash(options={})
    options[:methods] = %w{ title release_year rating storyline }
    super(options)
  end

  def attributes
    {}
  end

  def title
    release_year #about to delete the release year node, so we better save it
    title_and_release_year.css('span').remove
    title_and_release_year.text.strip
  end

  def release_year
    return @release_year if @release_year.present?
    title_and_release_year.css('span').text.match(/(\d+)/)
    @release_year = $1
  end

  def rating
    rating_container = overview.at_css('div[itemprop="aggregateRating"] .star-box-giga-star')
    rating_container ? rating_container.text.strip : nil
  end

  def storyline
    details.css('div.article').each do |article|
      article_headline = article.css('h2')
      next unless article_headline && article_headline.text == 'Storyline'
      storyline_element = article.at_css('p')
      storyline_element.at_css('em').remove
      return storyline_element.text.strip
    end
  end

  def self.search(term)
    search_result_rows = Dom.get("http://www.imdb.com/find?s=tt&q=#{term}").at_css('table.findList').children[0..(RESULT_LIMIT-1)]
    movies_from_anchor_tags search_result_rows.map{ |row| row.at_css('td.result_text a') }
  end

  def self.top_250(page)
    page = page.to_i
    return [] unless (1..25).to_a.include? page
    offset = (page - 1) * RESULT_LIMIT

    rows = []
    top_table = Dom.get('http://www.imdb.com/chart/top').css('div#main table')[1]
    top_table.children.each_with_index do |row, index|
      next if index <= offset
      next if offset == 0 && index == 0 #skip header row
      rows << row
      break if rows.size == RESULT_LIMIT
    end

    movies_from_anchor_tags rows.map{ |row| row.at_css('td a') }
  end

  private

  def doc
    @doc ||= Dom.get("http://www.imdb.com/title/#{@id}")
  end

  def content
    @content ||= doc.at_css('#pagecontent')
  end

  def overview
    @overview ||= content.at_css('#overview-top')
  end

  def title_and_release_year
    @tary ||= overview.at_css('h1.header')
  end

  def details
    @details ||= content.at_css('#maindetails_center_bottom')
  end

  def self.movies_from_anchor_tags(anchor_tags)
    anchor_tags.map do |anchor_tag|
      anchor_tag.attribute('href').to_s.match(/(tt[\d]+)/)
      Movie.new($1)
    end
  end

end