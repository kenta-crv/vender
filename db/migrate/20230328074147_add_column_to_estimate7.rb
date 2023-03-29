class AddColumnToEstimate7 < ActiveRecord::Migration[5.2]
  def change
    add_column :estimates, :aim, :string
    add_column :estimates, :attracting, :string
    add_column :estimates, :chagnge_remarks, :string
    add_column :estimates, :industry, :string
  end
end
