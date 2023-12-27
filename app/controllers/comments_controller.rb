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

  def update_status
    estimate = Estimate.find(params[:id])
    client = Client.find(params[:client_id])
    comment = Comment.find_or_initialize_by(estimate_id: estimate.id)

    # ステータスを更新する条件に基づいたロジック（例：params[:status_type]）
    case params[:status_type]
    when "contract"
      update_comment_status(client.company, "契約", comment)
    when "presentation"
      update_comment_status(client.company, "見積提示中", comment)
    when "conflict"
      update_comment_status(client.company, "他社NG", comment)
    end
  end

  private

  def update_comment_status(company, status, comment)
    case company
    when "アサヒ飲料株式会社 中部支社", "アサヒ飲料株式会社 関西支社", "アサヒ飲料株式会社"
      comment.update(asahi: status)
    when "コカ･コーラボトラーズジャパン株式会社"
      comment.update(cocacola: status)
    when "株式会社伊藤園"
      comment.update(itoen: status)
    when "ダイドードリンコ株式会社"
      comment.update(dydo: status)
    when "合同会社ファクトル"
      comment.update(yamakyu: status)
    when "ネオス株式会社"
      comment.update(neos: status)
    when "合同会社ファクトル"
      comment.update(body: status)
    end
  end

    #削除
  def valid_status_change?(comment, new_status)
    valid_statuses = ['見積提示', '設置NG']
    valid_statuses.include?(new_status)
  end
    #削除
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
