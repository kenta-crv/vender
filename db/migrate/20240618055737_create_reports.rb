class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.references :purchase, foreign_key: true
      t.string :status
      t.datetime :next
      t.string :body
      t.timestamps
      t.timestamps
    end
  end
end
