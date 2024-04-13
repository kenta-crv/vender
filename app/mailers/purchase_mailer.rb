class PurchaseMailer < ActionMailer::Base
  include Rails.application.routes.url_helpers
  default from: "secondhand@factoru.jp"
  def received_email(purchase)
    @purchase = purchase
    mail to: "secondhand@factoru.jp"
    mail(subject: '中古自動販売機のお見積もり依頼がありました') do |format|
      format.text
    end
  end

  def send_email(purchase)
    @purchase = purchase
    mail to: purchase.email
    mail(subject: '中古自動販売機をお問い合わせ頂きありがとうございます。') do |format|
      format.text
    end
  end

end
