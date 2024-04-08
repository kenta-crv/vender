class AddColumnsToTransfer < ActiveRecord::Migration[5.2]
  def change
    add_column :transfers, :document, :string
  end
end
