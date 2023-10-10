class EstimateMailer < ActionMailer::Base
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

  def outside_email(estimate)
    @estimate = estimate
    mail to: estimate.email
    mail(subject: '収益性の高い貸出型自販機のご案内') do |format|
      format.text
    end
  end

  def inside_email(estimate)
    @estimate = estimate
    mail to: estimate.email
    mail(subject: '実質利用でご利用可能な屋内ベンディングサービスのご案内') do |format|
      format.text
    end
  end

  def both_email(estimate)
    @estimate = estimate
    mail to: estimate.email
    mail(subject: '屋内ベンディングサービス・貸出型自販機のご案内') do |format|
      format.text
    end
  end

  def client_email(estimate,customer_id)
    @estimate = estimate
    mail bcc: Company.all.map{|company| company.mail}
    mail(subject: '自販機お見積もり依頼') do |format|
      format.text
    end
  end

  def client_email_select(estimate,select_companies)
    @estimate = estimate
    mail bcc: select_companies.map{|company| company.mail}
    mail(subject: '自販機お見積もり依頼') do |format|
      format.text
    end
  end
end
