# add directory to application load paths
# configatron.app.load_paths << ["app/helpers"]

Webmate::Application.configure do |config|
  # add directory to application load paths
  # configatron.app.load_paths << ["app/helpers"]
end

Webmate::Application.configure(:development) do |config|
  config.app.cache_classes = false
end

Webmate::Application.configure(:production) do |config|
  config.app.cache_classes = true
end