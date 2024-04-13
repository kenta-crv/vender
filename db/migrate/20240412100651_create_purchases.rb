class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.string :co #会社名
      t.string :name #名前
      t.string :tel #電話番号
      t.string :address #住所
      t.string :email #メールアドレス
      t.string :vender #自販機種類
      t.string :installment #分割
      t.string :option #オプション
      t.string :period #設置希望時期
      t.string :remarks #要望
      t.timestamps
    end
  end
end
