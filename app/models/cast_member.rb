class CastMember < SerializableObject

  def serialize_methods
    %w{ character person }
  end

  def initialize(table_row)
    @table_row = table_row
  end

  def character
    character_info = @table_row.at_css('td.character div')
    Character.new(character_info) if character_info
  end

  def person
    person_info = @table_row.at_css('td.name')
    Person.new(person_info) if person_info
  end

end