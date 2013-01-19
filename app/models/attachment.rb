class Attachment
  include Mongoid::Document
  mount_uploader :file, AttachmentUploader

  field :task_id
end