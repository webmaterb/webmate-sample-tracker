require 'capistrano/ext/multistage'
require 'bundler/capistrano'
require 'capistrano-rbenv'

set :stages, %w(staging production)
set :default_stage, "production"
set :deploy_via, :remote_cache
set :keep_releases, 5
set :scm, :git

before  'deploy:assets:precompile', 'db:create_symlink'
after   'deploy:create_symlink', 'deploy:cleanup'