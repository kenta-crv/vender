class AddColumnToNew < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :sanritsu, :string
    add_column :comments, :sanritsu_suggestion, :string
    add_column :comments, :sanritsu_file, :string
    add_column :comments, :sanritsu_remarks, :string
    add_column :comments, :ums, :string
    add_column :comments, :ums_suggestion, :string
    add_column :comments, :ums_file, :string
    add_column :comments, :ums_remarks, :string
  end
end
