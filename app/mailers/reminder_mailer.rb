# app/mailers/reminder_mailer.rb
class ReminderMailer < ApplicationMailer
  def send_reminder(client, estimate)
    @client = client
    @estimate = estimate
    mail(to: @client.email, subject: "自販機現地調査更新の依頼【#{@estimate.co}】")
  end
end