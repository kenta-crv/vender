namespace :estimates do
  task check_and_notify: :environment do
    Comment.where("inspection_start_date <= ?", Date.today - 10.days).each do |comment|
      EstimateMailer.expiration_notification(comment.estimate.client, comment, comment.estimate).deliver_now
    end

    Comment.where("inspection_start_date <= ?", Date.today - 15.days).each do |comment|
      EstimateMailer.expiration_notification(comment.estimate.client, comment, comment.estimate).deliver_now
    end
  end
end