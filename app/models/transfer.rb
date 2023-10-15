class Transfer < ApplicationRecord
    belongs_to :estimate
    mount_uploader :image, ImagesUploader
end
