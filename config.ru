require './config/environment'

map '/assets' do
  run Sinatra::Sprockets.environment
end

use Rack::CommonLogger
use Rack::PostBodyContentTypeParser
run WebmateApp