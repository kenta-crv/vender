class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :sales_price
      t.string :purchase_price
      t.string :image
      t.string :numbers
      t.string :manufacturer
      t.timestamps
    end
  end
end
