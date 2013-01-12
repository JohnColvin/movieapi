class CharacterPerson < SerializableObject

  def initialize(table_cell_contents)
    @table_cell_contents = table_cell_contents
  end

  def serialize_methods
    %w{ name page }
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