class TasksResponder < BaseResponder
  # Coming soon:
  #
  # resources :tasks
  # authorize :user do
  #   attributes :title, :status
  #   can :create
  #   can :update do |task|
  #     task.user_id == current_user.id
  #   end
  # end

  def read
    current_user.tasks
  end

  def create
    task = Task.new(params[:task])
    task.user_id = current_user._id
    task.save
    task
  end

  def update
    task = Task.find(params[:_id])
    attributes = params[:task]
    attributes.delete(:user_id)
    task.update_attributes(attributes)
    task
  end

  def delete
    task = Task.find(params[:_id])
    task.destroy
    task
  end
end