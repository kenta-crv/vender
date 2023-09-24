class CreateTransfers < ActiveRecord::Migration[5.2]
  def change
    create_table :transfers do |t|
      t.references :estimate, foreign_key: true
      t.string :bank
      t.string :branch
      t.string :number
      t.string :name
      t.string :body
      t.timestamps
    end
  end
end
