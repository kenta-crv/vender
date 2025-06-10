class CreateEmailLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :email_logs do |t|
      t.string :source           # estimate.id を保存（例: "123"）
      t.string :path             # アクセスされたパス（例: "/documents"）
      t.string :ip               # アクセス元のIPアドレス
      t.datetime :accessed_at    # アクセス日時
      t.timestamps
    end
  end
end
