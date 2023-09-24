class EstimatesController < ApplicationController
  before_action :authenticate_admin!, only: [:index, :show, :edit, :update, :destroy, :send_mail]
  add_breadcrumb "フォーム入力ページ", :new_estimate_path, only: [:confirm]
  def index
    @q = Estimate.ransack(params[:q])
    @estimates_for_view = @q.result.page(params[:page]).per(100).order(created_at: :desc)
  end

  def new
    @estimate = Estimate.new
  end

  def confirm
    @estimate = Estimate.new(estimate_params)
    add_breadcrumb "入力内容確認"
    if @estimate.valid?
      render :action =>  'confirm'
    else
      render :action => 'new'
    end
  end

  def thanks
    @estimate = Estimate.new(estimate_params)
    @estimate.save
    EstimateMailer.received_email(@estimate).deliver # 管理者に通知
    EstimateMailer.send_email(@estimate).deliver # 送信者に通知
  end

  def contract
    @estimates = Estimate.joins(:comment).where.not(sales_price: nil).where("comments.cocacola = ? OR comments.asahi = ? OR comments.itoen = ? OR comments.dydo = ? OR comments.yamakyu = ? OR comments.neos = ?", "契約", "契約", "契約", "契約", "契約", "契約")
  end

  def neos
    @estimates = Estimate.joins(:comment).where.not(percentage_other: 0).where("comments.neos": "契約")
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
    @transfer = Transfer.new
  end

  def edit
    @estimate = Estimate.find(params[:id])
  end

  def select_sent
    @company = Company.all
    render "selectcomp"
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

  def send_mail_cfsl
    @estimate = Estimate.find(params[:id])
    @comment = Comment.find_or_initialize_by(estimate_id: params[:id])
    customer_email = []
    customer_target = []
    params[:companies].each do |prms|
      prms[1].each do |prms|
        if prms != ""
          Rails.logger.info("set by #{prms}")
          comp = Company.find(prms)
          customer_email << comp.mail
          customer_target << comp.company
        end
      end
    end
    Rails.logger.info("set by #{customer_target}")
    customer_target.each do |target|
      if target == "ASAHI"
        @comment.update(asahi:"依頼中")
      elsif target == "コカ・コーラ"
        @comment.update(cocacola:"依頼中")
      elsif target == "伊藤園"
        @comment.update(itoen:"依頼中")
      elsif target == "ダイドードリンコ"
        @comment.update(dydo:"依頼中")
      else
        @comment.update(body:"依頼中")
      end
    end
    select_companies = []
    customer_target.each do |target|
      select_companies << Company.find_by(company: target)
    end
    EstimateMailer.client_email_select(@estimate, select_companies).deliver
    redirect_to "/estimates", alert: "#{@estimate.co}が指定した企業へ送信しました。"
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

  def sfa
    @q = Estimate.joins(:comment).where("comments.net": ["提案中","検討中"]).ransack(params[:q])
    @estimates_for_view = @q.result.page(params[:page]).per(100).order(created_at: :desc)
  end

  def payment
    @q = Estimate.joins(:transfer).where.not("transfers.id": nil).ransack(params[:q])
    @estimates_for_view = @q.result.page(params[:page]).per(100).order(created_at: :desc)
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
      :sales_price, #販売価格
      :assumed_total,
      :aim, #目的
      :attracting, #集客
      :chagnge_remarks, #交換詳細
      :industry, #業種
    )
  end
end
