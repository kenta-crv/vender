class Transfer < ApplicationRecord
    belongs_to :estimate
    mount_uploader :document, ImagesUploader
end
