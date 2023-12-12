class AddInspectionStartDateToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :inspection_start_date, :date
  end
end
