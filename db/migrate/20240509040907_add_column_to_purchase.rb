class AddColumnToPurchase < ActiveRecord::Migration[5.2]
  def change
    add_column :purchases, :thousand, :string
    add_column :purchases, :five_hundred, :string
    add_column :purchases, :five_ensure, :string
    add_column :purchases, :simple_wrapping, :string
    add_column :purchases, :design_wrapping, :string
  end
end
