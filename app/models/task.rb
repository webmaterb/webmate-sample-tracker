class Task
  include Mongoid::Document

  field :title
  field :status, default: 'backlog'
end