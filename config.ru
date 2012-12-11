require 'rubygems'
require 'sinatra'
require 'sinatra/synchrony'
require 'sinatra/contrib/all'
require 'sinatra-websocket'

require './lib/webmate/channels'

require './responders/tasks'

require './application'

run WebmateApp