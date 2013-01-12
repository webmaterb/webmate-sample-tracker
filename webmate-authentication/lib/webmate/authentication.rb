require 'warden'
require 'webmate'
require 'webmate/authentication/helpers'
require 'webmate/authentication/model'
require 'webmate/authentication/config'
require 'webmate/authentication/strategies/password'

Webmate::Application.register Webmate::Authentication::Helpers