require './config/environment'

map '/assets' do
  run Sinatra::Sprockets.environment
end

run WebmateApp