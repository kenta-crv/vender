class Estimate < ApplicationRecord
  belongs_to :company, optional: true
  has_one :comment, dependent: :destroy
  has_many :progresses, dependent: :destroy
  validates :co, {presence: true}
  validates :name, {presence: true}  #名前
  validates :tel, {presence: true} #電話番号
  validates :email, {presence: true} #メールアドレス
  validates :address, {presence: true} #住所
end
