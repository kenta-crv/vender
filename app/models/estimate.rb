class Estimate < ApplicationRecord
  belongs_to :company, optional: true
  has_one :comment, dependent: :destroy
  has_many :progresses, dependent: :destroy
  validates :co, presence: { message: '会社名が入力されていません。' }, on: :create
  validates :name, presence: { message: '名前が入力されていません。' }, on: :create
  validates :tel, presence: { message: '電話番号が入力されていません。' }, on: :create
  validates :email, presence: { message: 'メールアドレスが入力されていません。' }, on: :create
  validates :address, presence: { message: '住所が入力されていません。' }, on: :create

  def self.generate_csv
    CSV.generate(headers:true) do |csv|
      csv << csv_attributes
      all.each do |task|
        csv << csv_attributes.map{|attr| task.send(attr)}
      end
    end
  end

  def assumed_total
    percentage_i.to_i * assumed_number.to_i
  end



  def self.csv_attributes
    [
    "co", #会社名
    "name",  #名前
    "tel", #電話番号
    "postnumber", #郵便番号
    "address", #住所
    "email",
    "vender",
    "other",
    "installation", #設置箇所
    "people", #屋内の場合、使用が想定される人数
    "chenge", #自販機交換か
    "change_before", #交換前自販機
    "period", #設置希望時期
    "remarks" #要望
  ]
  end

end
