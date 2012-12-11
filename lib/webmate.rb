require './lib/webmate/config'
require './lib/webmate/channels'

configatron.app.load_paths.each do |path|
  Dir["#{path}/**/*.rb"].each { |app_class| load(app_class) }
end

class Sinatra::Base
  register Webmate::Channels
  set :_websockets, {}
end

require './config/config'
require './config/application'