class AddColumnsToNet < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :net, :string
  end
end
