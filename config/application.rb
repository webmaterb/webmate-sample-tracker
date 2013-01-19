class WebmateApp < Webmate::Application
  authentication_for :user

  get '/' do
    if user_signed_in?
      slim :"pages/index"
    else
      redirect '/users/sign_in'
    end
  end

  channel "projects/:project_id" do
    # Coming soon
    #
    # authorize do
    #   current_user.projects.include?(project)
    # end
    #
    get "tasks/read" => TasksResponder
    post "tasks/create" => TasksResponder
    put "tasks/update" => TasksResponder
    delete "tasks/delete" => TasksResponder

    post "attachments/create" => AttachmentsResponder
  end
end