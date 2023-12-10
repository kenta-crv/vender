class AddTokenToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :asahi_file, :string
    add_column :comments, :cocacola_file, :string
    add_column :comments, :itoen_file, :string
    add_column :comments, :neos_file, :string
    add_column :comments, :yamakyu_file, :string
    add_column :comments, :dydo_file, :string
  end
end
