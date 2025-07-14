class AddOldEmailSentAtToEstimates < ActiveRecord::Migration[5.2]
  def change
    add_column :estimates, :old_email_sent_at, :datetime
  end
end
