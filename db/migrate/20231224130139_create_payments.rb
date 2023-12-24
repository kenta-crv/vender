class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.references :estimate, foreign_key: true
      t.string :year
      t.string :month
      t.string :sales
      t.boolean :complete, default: false
      t.timestamps
    end
  end
end
