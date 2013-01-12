class SerializableObject

  include ActiveModel::Serializers::JSON
  include ActiveModel::Serializers::Xml

  def serializable_hash(options=nil)
    options ||= {}
    options[:methods] = serialize_methods
    super(options)
  end

  def attributes
    {}
  end
end