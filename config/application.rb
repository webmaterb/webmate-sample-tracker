class WebmateApp < Sinatra::Base
  get '/' do
    slim :"pages/index", layout: :layout
  end

  get '/users/sign_up' do
    user = User.new
    slim :"registrations/new", layout: :layout, locals: {user: user}
  end

  post '/users' do
    slim :"registrations/new", layout: :layout
  end

  channel "projects/:project_id" do
    get "tasks/read" => Responders::Tasks
    post "tasks/create" => Responders::Tasks
    put "tasks/update" => Responders::Tasks
  end
end