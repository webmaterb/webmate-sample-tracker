require './config/environment'

map '/assets' do
  run Sinatra::Sprockets.environment
end

use Rack::CommonLogger
use Rack::PostBodyContentTypeParser
use Rack::Session::Cookie, key: configatron.cookies.key,
                           domain: configatron.cookies.domain,
                           path: '/',
                           expire_after: 14400,
                           secret: configatron.cookies.secret
run WebmateApp