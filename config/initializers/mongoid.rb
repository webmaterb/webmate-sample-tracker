require 'mongoid'

if ENV['MONGOHQ_URL']
  db = URI.parse(ENV['MONGOHQ_URL'])
  db_name = db.path.gsub(/^\//, '')
  db_host = db.host
  db_port = db.port

  connection = Mongo::Connection.new(db_host, db_port)
  connection.db(db_name).authenticate(db.user, db.password)
else
  db_name = "webmate"
  db_host = "localhost"
  db_port = "27017"

  connection = Mongo::Connection.new(db_host, db_port)
end

Mongoid.configure do |config|
  config.allow_dynamic_fields = true
  config.master = connection.db(db_name)
end