class CommentsController < ApplicationController
  before_action :check_admin, except: [:edit, :update]
  before_action :check_client, only: [:edit, :update]
  before_action :load_estimate
  before_action :load_comment, only: [:edit,:update,:show,:destroy]
  #before_action :authenticate_user!

  def load_estimate
    @estimate = Estimate.find(params[:estimate_id])
    @comment = Comment.new
  end

  def load_comment
    @comment = Comment.find(params[:id])
  end

  def update_status
    @comment = Comment.find(params[:id])
    target = determine_target(@comment)
  
    # 権限の確認
    unless authorized_to_update_comment?(current_client, @comment, target)
      redirect_to root_path, alert: 'この操作には権限がありません。'
      return
    end
  
    if params[:new_status].present? && valid_status_change?(@comment, params[:new_status])
      # target に基づいて適切なカラムを更新
      update_comment_status(@comment, target, params[:new_status])
      @comment.update(comment_text: params[:comment_text])
      send_status_update_email(@comment)
      redirect_to somewhere_path, notice: 'ステータスが更新されました。'
    else
      redirect_to somewhere_path, alert: '無効なステータス更新です。'
    end
  end

  def update_comment_status(comment, target, new_status)
    case target
    when "アサヒ飲料株式会社 中部支社", "アサヒ飲料株式会社 関西支社", "アサヒ販売株式会社"
      comment.update(asahi: new_status)
    when "日本コカ･コーラ株式会社"
      comment.update(cocacola: new_status)
    end
  end

  def determine_target(comment)
    # Comment に関連する Estimate の company_name を取得して返す
    comment.estimate.company_name
  end

  def edit
    @estimate = Estimate.find(params[:estimate_id])
    # adminユーザーであれば、@clientは設定しない
    if admin_signed_in?
      # admin用の処理（必要に応じて）
    else
      # clientユーザーであれば、@clientを設定
      @client = Client.find(params[:client_id])
    end
  end

  def create
    @comment = @estimate.build_comment(comment_params)
    if @comment.save
      redirect_to estimate_path(@estimate)
    else
      render 'new'
    end
  end
  
  def destroy
    @comment = @estimate.comment
    @comment.destroy
    redirect_to estimate_path(@estimate)
  end
  
  def update
    @comment = @estimate.comment
    if admin_signed_in?
     if @comment.update(comment_params)
      redirect_to estimate_path(@estimate)
     else
      render 'edit'
     end
    elsif client_signed_in?
      if @comment.update(comment_params)
        flash[:notice] = "案件提案が完了しました"
        redirect_to root_path
       else
        render 'edit'
       end
    end
  end

  private
  def valid_status_change?(comment, new_status)
    # 有効なステータスの例
    valid_statuses = ['見積提示', '設置NG']
    # 新しいステータスが有効なリストに含まれているか確認
    valid_statuses.include?(new_status)
  end

  def send_status_update_email(comment)
    EstimateMailer.status_update_email(comment).deliver_now
  end

 	def comment_params
 		params.require(:comment).permit(
 		:asahi,
    :cocacola,
    :dydo,
    :itoen,
    :kirin,
    :otsuka,
    :suntory,
    :yamakyu,
    :neos,
    :net,
    :body,
    :asahi_suggestion,
    :asahi_file,
    :asahi_remarks,
    :cocacola_suggestion,
    :cocacola_file,
    :cocacola_remarks,
    :itoen_suggestion,
    :itoen_file,
    :itoen_remarks,
    :neos_suggestion,
    :neos_file,
    :neos_remarks,
    :yamakyu_suggestion,
    :yamakyu_file,
    :yamakyu_remarks,
    :dydo_suggestion,
    :dydo_file,
    :dydo_remarks,
    )
 	end
end
