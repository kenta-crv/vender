class AddColumnToEstimate5 < ActiveRecord::Migration[5.2]
  def change
    add_column :estimates, :percentage_i, :string
    add_column :estimates, :percentage_other, :string
    add_column :estimates, :assumed_number, :string
  end
end
