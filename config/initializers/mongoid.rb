require 'mongoid'

if ENV['MONGOHQ_URL']
  db = URI.parse(ENV['MONGOHQ_URL'])
  db_name = db.path.gsub(/^\//, '')
  db_host = db.host
  db_port = db.port
else
  db_name = "webmate"
  db_host = "localhost"
  db_port = "27017"
end

Mongoid.configure do |config|
  config.allow_dynamic_fields = true
  config.master = Mongo::Connection.new(db_host, db_port).db(db_name)
end