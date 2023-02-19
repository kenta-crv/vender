class EstimatesController < ApplicationController
  before_action :authenticate_admin!, only: [:index, :show, :edit, :update, :destroy, :send_mail]

  def index
    @q = Estimate.ransack(params[:q])
    @estimates = @q.result.page(params[:page]).per(100).order(created_at: :desc)
    #respond_to do |format|
    #  format.html
    #  format.csv do
    #    send_data @estimates.generate_csv, filename: "estimates-#{Time.zone.now.strftime('%Y%m%d%S')}.csv"
    #  end
    #end
  end

  def new
    @estimate = Estimate.new
  end

  def confirm
    @estimate = Estimate.new(estimate_params)
  end

  def thanks
    @estimate = Estimate.new(estimate_params)
    @estimate.save
    EstimateMailer.received_email(@estimate).deliver # 管理者に通知
    EstimateMailer.send_email(@estimate).deliver # 送信者に通知
  end

  def contract
    @estimates = Estimate.where.not(assumed_number: nil)
  end

  def create
    @estimate = Estimate.new(estimate_params)
    @estimate.save
    redirect_to thanks_estimates_path
  end

  def show
    @estimate = Estimate.find(params[:id])
    @comment = Comment.new
    @progress = Progress.new
  end

  def edit
    @estimate = Estimate.find(params[:id])
  end

  def destroy
    @estimate = Estimate.find(params[:id])
    @estimate.destroy
    redirect_to estimates_path, alert:"削除しました"
  end

  def update
    @estimate = Estimate.find(params[:id])
    if @estimate.update(estimate_params)
      redirect_to estimates_path(@estimate), alert: "更新しました"
    else
      render 'edit'
    end
  end

  def send_mail
    @estimate = Estimate.find(params[:id])
    @estimate.update(send_mail_flag: true)
    EstimateMailer.client_email(@estimate).deliver # 全企業に送信
    redirect_to estimate_path(@estimate), alert: "送信しました"
  end

  def apply
    estimate = Estimate.find(params[:id])
    room = estimate.rooms.find_by(member_id: current_member.id)

    if room.blank?
      # 初めての場合
      if current_member.point >= 10
        # ポイントを減らす
        current_member.update(point: current_member.point - 10)
        room = Room.get_room_in(estimate.user, current_member)
        content = "会社名: #{estimate.co} \n担当者名: #{estimate.name} \n電話番号: #{estimate.tel} \nメールアドレス: #{estimate.email} \n住所: #{estimate.address} \n従業員数: #{estimate.employment} \n募集職種: #{estimate.business} \n重要な点: #{estimate.importance} \n募集人材: #{estimate.recruitment} \n必要人数: #{estimate.people} \n必要時期: #{estimate.period} \n相談内容: #{estimate.remarks}"
        Message.create(is_user: true, room_id: room.id, content: content, estimate_id: estimate.id)
        redirect_to room_messages_path(uri_token: room.uri_token), alert: "10ポイント消費しました"
      else
        redirect_to member_path(current_member), alert: "ポイントが足りません"
      end
    else
      # 既に応募済の場合
      redirect_to room_messages_path(uri_token: room.uri_token)
    end
  end

  def recruit
    @estimates = Estimate.order(created_at: "DESC").where(send_mail_flag: "送信済").page(params[:page])
  end

  private
  def estimate_params
    params.require(:estimate).permit(
      :co, #会社名
      :name,  #名前
      :tel, #電話番号
      :postnumber, #郵便番号
      :address, #住所
      :email,
      :vender,
      :other,
      :installation, #設置箇所
      :people, #屋内の場合、使用が想定される人数
      :chenge, #自販機交換か
      :change_before, #交換前自販機
      :period, #設置希望時期
      :remarks, #要望
      :word, #社内情報
      :percentage_i, #パーセンテージ
      :percentage_other, #パーセンテージ
      :assumed_number, #想定本数
    )
  end
end
