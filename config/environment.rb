require 'rubygems'
require 'sinatra'
require 'sinatra/synchrony'
require 'sinatra/contrib/all'
require 'sinatra-websocket'
require 'configatron'
require 'closure-compiler'
require 'yui/compressor'

require './lib/webmate'

class WebmateApp < Sinatra::Base; end;

Sinatra::Sprockets.configure do |config|
  config.app = WebmateApp

  ['stylesheets', 'javascripts', 'images'].each do |dir|
    config.append_path(File.join('..', 'app', 'assets', dir))
  end
  config.precompile = [ /\w+\.(?!js|css).+/, /application.(css|js)/ ]
end