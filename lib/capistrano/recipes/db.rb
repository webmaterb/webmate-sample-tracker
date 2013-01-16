namespace :db do
  desc "Make symlink for mongoid.yml"
  task :create_symlink do
    run "ln -nfs #{shared_path}/config/mongoid.yml #{latest_release}/config/mongoid.yml"
  end
end