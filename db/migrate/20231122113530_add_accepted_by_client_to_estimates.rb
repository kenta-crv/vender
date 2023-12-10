class AddAcceptedByClientToEstimates < ActiveRecord::Migration[5.2]
  def change
    add_column :estimates, :accepted_by_client, :boolean
  end
end
