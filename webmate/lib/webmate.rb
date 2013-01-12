ENV["RACK_ENV"] ||= "development"

require "sinatra"
require "sinatra/synchrony"
require "sinatra/contrib"
require "sinatra-websocket"
require "yajl"
require "configatron"
require "rack/contrib/post_body_content_type_parser"

require 'bundler'
Bundler.setup
Bundler.require(:default, ENV["RACK_ENV"].to_sym)
if ENV["RACK_ENV"] == 'development'
  Bundler.require(:assets)
end

require 'webmate/env'
require 'webmate/config'
require 'webmate/channels'
require 'webmate/support/thin'
require 'webmate/support/sprockets'
require 'webmate/responders/base'
require 'webmate/services/base'
require 'webmate/observers/base'
require 'webmate/decorators/base'

module Responders; end;
module Services; end;
module Decorators; end;
module Observers; end;

require "#{WEBMATE_ROOT}/config/config"

class Sinatra::Base
  disable :threaded
  register Webmate::Channels
  helpers Sinatra::Sprockets::Helpers
  set :_websockets, {}
  set :public_path, '/public'
  set :root, WEBMATE_ROOT
  set :views, Proc.new { File.join(root, 'app', "views") }
end

configatron.app.load_paths.each do |path|
  Dir["#{WEBMATE_ROOT}/#{path}/**/*.rb"].each { |app_class| load(app_class) }
end

Sinatra::Sprockets.configure do |config|
  config.app = Sinatra::Base
  ['stylesheets', 'javascripts', 'images'].each do |dir|
    # require application assets
    config.append_path(File.join('app', 'assets', dir))
  end
  config.precompile = [ /\w+\.(?!js|css).+/, /application.(css|js)/ ]
  config.compress = configatron.assets.compress
  config.debug = configatron.assets.debug
end

path = File.expand_path("#{WEBMATE_ROOT}/config/initializers/*.rb")
Dir[path].each { |initializer| require(initializer) }

require "#{WEBMATE_ROOT}/config/application"