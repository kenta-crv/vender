class AddClientIdToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :client_id, :integer
  end
end
