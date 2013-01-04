require 'webmate/config'
require 'webmate/channels'
require 'webmate/sprockets'
require 'webmate/responders/base'
require 'webmate/services/base'

module Responders
end

module Services
end

configatron.app.load_paths.each do |path|
  Dir["#{path}/**/*.rb"].each { |app_class| load(app_class) }
end

class Sinatra::Base
  register Webmate::Channels
  helpers Sinatra::Sprockets::Helpers
  set :_websockets, {}
  set :public_path, '/public'
  set :root, File.expand_path('.')
  set :views, Proc.new { File.join(root, 'app', "views") }
end

require './config/config'
require './config/application'