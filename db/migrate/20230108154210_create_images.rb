class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.references :company, foreign_key: true
      t.string :title
      t.string :picture
      t.timestamps
    end
  end
end
