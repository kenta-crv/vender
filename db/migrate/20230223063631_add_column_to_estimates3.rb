class AddColumnToEstimates3 < ActiveRecord::Migration[5.2]
  def change
    add_column :estimates, :sales_price, :string
  end
end
