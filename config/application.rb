class WebmateApp < Sinatra::Base
  get '/' do
    slim :index, layout: :layouts
  end

  channel "projects/:project_id" do
    get "tasks/read" => Responders::Tasks
    post "tasks/create" => Responders::Tasks
    put "tasks/update" => Responders::Tasks
  end
end