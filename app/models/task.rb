class Task
  include Mongoid::Document

  field :title
  field :status, default: 'backlog'
  field :user_id

  validates :title, presence: true
  validates :user_id, presence: true
end