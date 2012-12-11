class WebmateApp < Sinatra::Base
  get '/' do
    configatron.hello.world
  end

  channel "projects/:project_id" do
    get "tasks/list" => Responders::Tasks
    post "tasks/create" => Responders::Tasks
    patch "tasks/update" => Responders::Tasks
  end

  channel "groups/:group_id" do
    get "tasks/list" => Responders::Tasks
    post "tasks/create" => Responders::Tasks
    patch "tasks/update" => Responders::Tasks
  end
end