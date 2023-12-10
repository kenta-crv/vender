class AddDisclosedToEstimates < ActiveRecord::Migration[5.2]
  def change
    add_column :estimates, :disclosed, :boolean
  end
end
