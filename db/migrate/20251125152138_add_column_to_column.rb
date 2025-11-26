class AddColumnToColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :columns, :file, :string           # ファイル
    add_column :columns, :choice, :string         # 選択
    add_column :columns, :keyword, :string        # キーワード
    add_column :columns, :status, :string, default: "draft" # 説明
    add_column :columns, :body, :text             # 本文
  end
end
