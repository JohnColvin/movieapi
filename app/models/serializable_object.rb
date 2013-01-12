class SerializableObject

  include ActiveModel::Serializers::JSON
  include ActiveModel::Serializers::Xml

  self.include_root_in_json = false

  def serializable_hash(options=nil)
    options ||= {}
    options[:methods] = serialize_methods
    super(options)
  end

  def attributes
    {}
  end
end