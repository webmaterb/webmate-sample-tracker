require './config/environment'
if configatron.assets.compile
  map '/assets' do
    run Sinatra::Sprockets.environment
  end
end
run WebmateApp