namespace :estimates do
  # rakeコマンド実行ができているか確認するrakeタスク
  # コマンド：rake estimates:test
  task test: :environment do
    puts "CURRENT TIME:#{Time.zone.now.strftime('%Y-%m-%d %H:%M')}"
  end

  task check_and_notify: :environment do
    Comment.where("inspection_start_date <= ?", Date.today - 10.days).each do |comment|
      EstimateMailer.expiration_notification(comment.estimate.client, comment, comment.estimate).deliver_now
    end

    Comment.where("inspection_start_date <= ?", Date.today - 15.days).each do |comment|
      EstimateMailer.expiration_notification(comment.estimate.client, comment, comment.estimate).deliver_now
    end
  end

  # 催促メール送信のrakeタスク
  # コマンド：rake estimates:send_remind_email
  task send_remind_email: :environment do
    # 先にClientを取得する
    clients = Client.related_companies

    # 依頼中のまま特定日数(5/10日)経過しているComment
    [5, 10].each do |days_ago|
      Comment.requested_remind_email_target(days_ago).each do |comment|
        Comment::STATUS_TO_CLIENT.each do |status, companies|
          next unless comment.send(status) == '依頼中'

          companies.each do |company|
            client = clients[company]
            EstimateMailer.requested_status_remaind(comment, client).deliver_now if client.present?
          end
        end
      end
    end

    # 現地調査中のまま特定日数(5/10日)経過しているComment
    [5, 10].each do |days_ago|
      Comment.investigated_remind_email_target(days_ago).each do |comment|
        Comment::STATUS_TO_CLIENT.each do |status, companies|
          next unless comment.send(status) == '現地調査中'

          companies.each do |company|
            client = clients[company]
            EstimateMailer.investigated_status_remaind(comment, client).deliver_now if client.present?
          end
        end
      end
    end
  end

end