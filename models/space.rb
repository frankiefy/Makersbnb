class Space
  include DataMapper::Resource

  # has n, :tags, through: Resource

  property :id, Serial
  property :name, String
  property :description,  String
  property :price, String

end
