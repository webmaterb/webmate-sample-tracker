class WebmateApp < Webmate::Application
  authentication_for :user

  get '/' do
    if user_signed_in?
      slim :"pages/index"
    else
      redirect '/users/sign_in'
    end
  end

  get '/users/sign_up' do
    user = User.new
    slim :"registrations/new", locals: {user: user}
  end

  post '/users/sign_up' do
    user = User.new(params[:user])
    if user.save
      redirect '/'
    else
      slim :"registrations/new"
    end
  end

  channel "projects/:project_id" do
    # Coming soon
    #
    # authorize do
    #   current_user.projects.include?(project)
    # end
    #
    get "tasks/read" => Responders::Tasks
    post "tasks/create" => Responders::Tasks
    put "tasks/update" => Responders::Tasks
    delete "tasks/delete" => Responders::Tasks
  end
end