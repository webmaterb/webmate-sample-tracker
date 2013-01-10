ENV["RACK_ENV"] ||= "development"

require 'bundler'
Bundler.setup
Bundler.require(:default, ENV["RACK_ENV"].to_sym)

require 'webmate/config'
require 'webmate/channels'
require 'webmate/support/thin'
require 'webmate/support/sprockets'
require 'webmate/responders/base'
require 'webmate/services/base'
require 'webmate/observers/base'
require 'webmate/decorators/base'

module Responders
end
module Services
end
module Decorators
end
module Observers
end

configatron.app.load_paths.each do |path|
  Dir["#{path}/**/*.rb"].each { |app_class| load(app_class) }
end

class Sinatra::Base
  disable :threaded
  register Webmate::Channels
  helpers Sinatra::Sprockets::Helpers
  set :_websockets, {}
  set :public_path, '/public'
  set :root, File.expand_path('.')
  set :views, Proc.new { File.join(root, 'app', "views") }
end

require './config/config'
require './config/application'