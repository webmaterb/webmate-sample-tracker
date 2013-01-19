class Attachment
  include Mongoid::Document
  mount_uploader :file, Uploaders::Attachment

  field :task_id
end