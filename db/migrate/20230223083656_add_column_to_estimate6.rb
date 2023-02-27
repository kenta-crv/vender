class AddColumnToEstimate6 < ActiveRecord::Migration[5.2]
  def change
    add_column :estimates, :assumed_total, :string
  end
end
