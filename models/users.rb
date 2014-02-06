class Users
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :school, String
  property :klass, String
  property :lastdatestamp, Integer

end