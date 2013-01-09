class WebmateApp < Sinatra::Base
  get '/' do
    slim :index, layout: :layouts
  end

  channel "projects/:project_id" do
    get "tasks/read" => Responders::Tasks
    post "tasks/create" => Responders::Tasks
    patch "tasks/update" => Responders::Tasks
  end

  channel "groups/:group_id" do
    get "tasks/read" => Responders::Tasks
    post "tasks/create" => Responders::Tasks
    patch "tasks/update" => Responders::Tasks
  end
end