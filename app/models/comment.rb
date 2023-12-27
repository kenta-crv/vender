class Comment < ApplicationRecord
  belongs_to :estimate
  mount_uploader :asahi_file, ImagesUploader
  mount_uploader :cocacola_file, ImagesUploader
  mount_uploader :itoen_file, ImagesUploader
  mount_uploader :yamakyu_file, ImagesUploader
  mount_uploader :neos_file, ImagesUploader
  mount_uploader :dydo_file, ImagesUploader

  # ステータス変更を検知するためのコールバック
  after_save :send_email_notifications, if: :status_changed?

  private

  def status_changed?
    cocacola_changed? || neos_changed? || itoen_changed? || asahi_changed? || dydo_changed? || yamakyu_changed? || body_changed?
  end

  def send_email_notifications
    client = estimate.client
    if body == '契約'
      send_contract_email(client)
    elsif body == '他社NG'
      send_conflict_email(client)
    elsif body == '見積提示中'
      send_presentation_email(client)
    end
    # ...[他の条件]...
  end
  def send_contract_email(client)
    EstimateMailer.contract_email(estimate, self, client).deliver_now
  end

  def send_conflict_email(client)
    EstimateMailer.conflict_email(estimate, self, client).deliver_now
  end

  def send_presentation_email(client)
    EstimateMailer.presentation_email(estimate, self, client).deliver_now
  end
end
