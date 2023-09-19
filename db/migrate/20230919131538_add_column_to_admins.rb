class AddColumnToAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :user_name, :string
  end
end
