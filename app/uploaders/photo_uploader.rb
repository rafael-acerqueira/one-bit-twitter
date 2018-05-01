class PhotoUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
  process :convert => 'png'

  version :profile do
    process :resize_to_fill => [100, 100, :north]
  end

  version :post do
    process :resize_to_fill => [200, 200, :north]
  end
end
