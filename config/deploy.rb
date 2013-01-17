require 'capistrano/ext/multistage'
require 'bundler/capistrano'
require 'capistrano-rbenv'

set :stages, %w(staging production)
set :default_stage, "production"
set :deploy_via, :copy
set :keep_releases, 5
set :scm, :git
set :server_type, "thin"

after     'deploy:update_code', 'thin:create_symlink'
after     'deploy:update_code', 'db:create_symlink'
after     'deploy:create_symlink', 'deploy:cleanup'

namespace :db do
  desc "Make symlink for mongoid.yml"
  task :create_symlink do
    run "ln -nfs #{shared_path}/config/mongoid.yml #{latest_release}/config/mongoid.yml"
  end
end