class AttachmentUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "#{Webmate.root}/public/uploads"
  end
end