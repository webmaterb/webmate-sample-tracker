require 'mongoid'

config = YAML.load_file("#{WEBMATE_ROOT}/config/mongoid.yml")
db = config[Webmate.env]["sessions"]["default"]

db_host_and_port = db['hosts'].first.split(':')
db_name = db['database']
db_host = db_host_and_port[0]
db_port = db_host_and_port[1]

connection = Mongo::Connection.new(db_host, db_port)

Mongoid.configure do |config|
  config.master = connection.db(db_name)
end