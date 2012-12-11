require 'rubygems'
require 'sinatra'
require 'sinatra/synchrony'
require 'sinatra/contrib/all'
require 'sinatra-websocket'
require 'configatron'

require './lib/webmate'
run WebmateApp