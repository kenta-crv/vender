class AddDisclosureClickedAtToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :disclosure_clicked_at, :datetime
  end
end
