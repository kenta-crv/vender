class Image < ApplicationRecord
  belongs_to :company
  mount_uploader :picture, ImagesUploader
end
