class AddColumnToProgress < ActiveRecord::Migration[5.2]
  def change
    add_column :progresses, :document, :string
    add_column :progresses, :next, :date
  end
end
