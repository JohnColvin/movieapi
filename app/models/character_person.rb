class CharacterPerson

  include ActiveModel::Serializers::JSON
  include ActiveModel::Serializers::Xml

  def initialize(table_cell_contents)
    @table_cell_contents = table_cell_contents
  end

  def serializable_hash(options=nil)
    options ||= {}
    options[:methods] = %w{ name page }
    super(options)
  end

  def attributes
    {}
  end

  def name
    link ? link.text : @table_cell_contents.text
  end

  def page
    Movie::IMDB_URL + link.attribute('href').text if link
  end

  private

  def link
    @table_cell_contents.at_css('a')
  end
end