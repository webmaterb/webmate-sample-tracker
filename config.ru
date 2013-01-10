require './config/environment'

map '/assets' do
  run Sinatra::Sprockets.environment
end

use Rack::CommonLogger
run WebmateApp