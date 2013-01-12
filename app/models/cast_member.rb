class CastMember

  include ActiveModel::Serializers::JSON
  include ActiveModel::Serializers::Xml

  def initialize(table_row)
    @table_row = table_row
  end

  def serializable_hash(options=nil)
    options ||= {}
    options[:methods] = %w{ character person }
    super(options)
  end

  def attributes
    {}
  end

  def character
    character_info = @table_row.at_css('td.character div')
    Character.new(character_info) if character_info
  end

  def person
    Person.new(@table_row.at_css('td.name'))
  end

end