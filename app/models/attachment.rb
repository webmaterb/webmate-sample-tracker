class Attachment
  include Mongoid::Document
  mount_uploader :file, AttachmentUploader
  embedded_in :task
end