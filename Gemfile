source 'https://rubygems.org'

gem 'webmate', path: File.dirname(__FILE__) + '/webmate'

gem 'sinatra'
gem 'sinatra-synchrony'
gem 'sinatra-contrib'
gem 'sinatra-websocket'
gem 'thin'
gem 'yajl-ruby'
gem 'configatron'
gem 'slim'
gem 'bson_ext'
gem 'mongoid', '2.5.1'
gem 'em-synchrony', git: 'git://github.com/igrigorik/em-synchrony.git'

group :assets do
  gem 'therubyracer', '0.10.2'
  gem 'alphasights-sinatra-sprockets', require: 'sinatra-sprockets',
      git: 'git://github.com/droidlabs/sinatra-sprockets.git'
  gem 'closure-compiler'
  gem 'yui-compressor'
  gem 'coffee-script'
end

group :development do
  gem 'capistrano', '2.13.5'
  gem 'capistrano-rbenv', '0.0.8'
end

group :test do
    gem 'rspec'
    gem 'rack-test', :require => "rack/test"
end