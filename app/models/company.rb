class Company < ApplicationRecord
 has_many :estimates
 has_many :images
 mount_uploader :image, ImagesUploader
 #validates :company, {presence: true}#会社名
 #validates :name, {presence: true}#代表者
 #validates :tel, {presence: true}
 #validates :mail, {presence: true}#URL
end
