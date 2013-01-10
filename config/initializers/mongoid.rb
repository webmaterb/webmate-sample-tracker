require 'mongoid'
# Mongoid.load!('./config/mongoid.yml', :development)
Mongoid.configure do |config|
   name = "webmate"
   host = "localhost"
   config.allow_dynamic_fields = true
   config.master = Mongo::Connection.new.db(name)
end