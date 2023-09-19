class AddAdminIdToProgresses < ActiveRecord::Migration[5.2]
  def change
    add_column :progresses, :admin_id, :integer
  end
end
