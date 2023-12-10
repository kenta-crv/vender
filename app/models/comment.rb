class Comment < ApplicationRecord
  belongs_to :estimate
  mount_uploader :asahi_file, ImagesUploader
  mount_uploader :cocacola_file, ImagesUploader
  mount_uploader :itoen_file, ImagesUploader
  mount_uploader :yamakyu_file, ImagesUploader
  mount_uploader :neos_file, ImagesUploader
  mount_uploader :dydo_file, ImagesUploader
end
