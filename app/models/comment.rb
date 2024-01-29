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
  after_save :send_change_status_notifications, if: :send_change_status_notifications_status?

  # ステータスとClient.companyのマッピング
  STATUS_TO_CLIENT = {
    'asahi' => [
      'アサヒ飲料株式会社 中部支社', 
      'アサヒ飲料株式会社 関西支社', 
      'アサヒ飲料株式会社'
    ],
    'cocacola' => ['コカ･コーラボトラーズジャパン株式会社'],
    'itoen' => ['株式会社伊藤園'],
    'dydo' => ['ダイドードリンコ株式会社'],
    'yamakyu' => ['合同会社ファクトル'],
    'neos' => ['ネオス株式会社']
  }.freeze

  # 催促メール対象取得の取得(ステータス:依頼中)
  # 引数：days_ago(何日前のデータを取得するか)
  scope :requested_remind_email_target, ->(days_ago) {
    target_date = days_ago.days.ago.to_date
    where(asahi: '依頼中', created_at: target_date.beginning_of_day..target_date.end_of_day)
      .or(Comment.where(cocacola: '依頼中', created_at: target_date.beginning_of_day..target_date.end_of_day))
      .or(Comment.where(itoen: '依頼中', created_at: target_date.beginning_of_day..target_date.end_of_day))
      .or(Comment.where(dydo: '依頼中', created_at: target_date.beginning_of_day..target_date.end_of_day))
      .or(Comment.where(yamakyu: '依頼中', created_at: target_date.beginning_of_day..target_date.end_of_day))
      .or(Comment.where(neos: '依頼中', created_at: target_date.beginning_of_day..target_date.end_of_day))
  }

  # 催促メール対象取得の取得(ステータス:現地調査中)
  # 引数：days_ago(何日前のデータを取得するか)
  scope :investigated_remind_email_target, ->(days_ago) {
    target_date = days_ago.days.ago.to_date
    where(asahi: '現地調査中', updated_at: target_date.beginning_of_day..target_date.end_of_day)
      .or(Comment.where(cocacola: '現地調査中', updated_at: target_date.beginning_of_day..target_date.end_of_day))
      .or(Comment.where(itoen: '現地調査中', updated_at: target_date.beginning_of_day..target_date.end_of_day))
      .or(Comment.where(dydo: '現地調査中', updated_at: target_date.beginning_of_day..target_date.end_of_day))
      .or(Comment.where(yamakyu: '現地調査中', updated_at: target_date.beginning_of_day..target_date.end_of_day))
      .or(Comment.where(neos: '現地調査中', updated_at: target_date.beginning_of_day..target_date.end_of_day))
  }

  private

  def status_changed?
    cocacola_changed? || neos_changed? || itoen_changed? || asahi_changed? || dydo_changed? || yamakyu_changed? || body_changed?
  end

  def send_email_notifications
    client = estimate.client
    if body == '契約'
      send_contract_email(client)
    elsif body == '見送りNG'
      send_conflict_email(client)
    elsif body == '見積提示中'
      send_presentation_email(client)
    end
    # ...[他の条件]...
  end

  # ステータス変更に応じたメール通知が必要？
  def send_change_status_notifications_status?
    saved_change_to_cocacola? || saved_change_to_neos? || saved_change_to_itoen? || saved_change_to_asahi? || saved_change_to_dydo? || saved_change_to_yamakyu?
  end

  # ステータス変更に応じたメール通知
  def send_change_status_notifications
    # 先にClientを取得
    clients = Client.where(company: Comment::STATUS_TO_CLIENT.values.flatten).index_by(&:company)

    changed_statuses = get_changed_status

    # メール送信対象ステータスの変更ではない場合は後続処理はしない
    return if changed_statuses.blank?

    changed_statuses.each do |changed_status|
      field = changed_status[:field]
      status = changed_status[:status]
      companies = Comment::STATUS_TO_CLIENT[field]

      next if companies.blank?

      companies.each do |company|
        client = clients[company]
        EstimateMailer.estimate_status_notification(self, client).deliver_later if status == '見積提示中'
        EstimateMailer.contracted_status_notification(self, client).deliver_later if status == '契約'
        EstimateMailer.send_off_status_notification(self, client).deliver_later if status == '見送りNG'
      end
    end
  end

  # どのステータスに変更されたかを返す
  # 更新された項目をハッシュの配列で返す　例：[{field:'cocacola', status:'見積提示中}, {field: 'neos', status: '契約'}]
  def get_changed_status
    specific_statuses = ['見積提示中', '契約', '見送りNG']
    fields = ['cocacola', 'neos', 'itoen', 'asahi', 'dydo', 'yamakyu']
    changed_statuses = []
  
    fields.each do |field|
      if send("saved_change_to_#{field}?") && specific_statuses.include?(send(field))
        changed_statuses << { field: field, status: send(field) }
      end
    end

    changed_statuses.presence
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
