class CreateAddColumnToComments < ActiveRecord::Migration[5.2]
  def change
    create_table :add_column_to_comments do |t|
      t.timestamps
    end
  end
end
