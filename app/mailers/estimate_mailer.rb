class EstimateMailer < ActionMailer::Base
  include Rails.application.routes.url_helpers
  default from: "zihanki@factoru.jp"
  def received_email(estimate)
    @estimate = estimate
    mail to: "zihanki@factoru.jp"
    mail(subject: '自販機ねっとにお見積もり依頼がありました') do |format|
      format.text
    end
  end

  def send_email(estimate)
    @estimate = estimate
    mail to: estimate.email
    mail(subject: '自販機現地調査開始のご案内') do |format|
      format.text
    end
  end

  def old_email(estimate)
    @estimate = estimate
    mail to: estimate.email
    mail(subject: '最長5年保証で運営出来る新中古自販機のご案内') do |format|
      format.text
    end
  end

  def share_email(estimate)
    @estimate = estimate
    mail to: estimate.email
    mail(subject: 'ドコモシェアサイクルで副収入と社会貢献！') do |format|
      format.text
    end
  end

  def outside_email(estimate)
    @estimate = estimate
    mail to: estimate.email
    mail(subject: '収益性の高い貸出型自販機のご案内') do |format|
      format.text
    end
  end

  def client_email(estimate,customer_id)
    @estimate = estimate
    mail bcc: Client.all.map{|client| client.email}
    mail(subject: '自販機お見積もり依頼') do |format|
      format.text
    end
  end

  def client_email_select(estimate, client)
    @estimate = estimate
    @client = client
    @accept_link = accept_estimate_url(@estimate, client_id: @client.id)
    @decline_link = decline_estimate_url(@estimate, client_id: @client.id)
    mail(to: client.email, subject: "自販機現地調査依頼【#{@estimate.co}】", content_type: "text/plain; charset=UTF-8", content_transfer_encoding: '7bit') 
  end

  def status_update_email(comment)
    @comment = comment
    mail(to: 'zihanki@factoru.jp', from: comment.client.email, subject: 'ステータス更新通知')
  end

  def client_public_email(estimate, client, comment)
    @estimate = estimate
    @client = client
    @comment = comment
    mail(to: @client.email, subject: "#{client.company}の情報が公開されました。")
  end
  
  def net_accept_email(estimate, client)
    @estimate = estimate
    @client = client
    mail(from: @client.email, to: 'zihanki@factoru.jp', subject: "#{client.company}が案件を受託しました。")
  end

  def net_decline_email(estimate, client)
    @estimate = estimate
    @client = client
    mail(from: @client.email, to: 'zihanki@factoru.jp', subject: "#{client.company}が案件を辞退しました")
  end

  #催促
  def expiration_notification(client, comment, estimate)
    @client = client
    @comment = comment
    @estimate = estimate
    mail(to: @client.email,  subject: "【#{@estimate.co}】現地調査結果を更新してください")
  end
  #契約メール
  def contract_email(estimate, comment, client)
    @estimate = estimate
    @comment = comment
    @client = client
    mail(to: client.email, subject: '【#{@estimate.co}】で契約依頼がありました')
  end
  #競合NGメール
  def conflict_email(estimate, comment, client)
    @estimate = estimate
    @comment = comment
    @client = client
    mail(to: client.email, subject: '【#{@estimate.co}】はご検討の結果落選となりました')
  endf
  #見積提示中メール
  def presentation_email(estimate, comment, client)
    @estimate = estimate
    @comment = comment
    @client = client
    mail(to: "zihanki@factoru.jp", from: client.email subject: '【#{@estimate.co}】#{@client.company}が提案を行いました')
  end
end
