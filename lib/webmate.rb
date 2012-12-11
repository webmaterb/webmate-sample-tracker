require './lib/webmate/config'
require './lib/webmate/channels'
require './lib/webmate/sprockets'

configatron.app.load_paths.each do |path|
  Dir["#{path}/**/*.rb"].each { |app_class| load(app_class) }
end

class Sinatra::Base
  register Webmate::Channels
  helpers Sinatra::Sprockets::Helpers
  set :_websockets, {}
  set :public_path, '/public'
end

require './config/config'
require './config/application'