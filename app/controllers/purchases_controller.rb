class PurchasesController < ApplicationController
    before_action :check_admin, except: [:new, :confirm, :thanks]
    add_breadcrumb "フォーム入力ページ", :new_purchase_path, only: [:confirm]
    def index
      @q = Purchase.ransack(params[:q])
      @purchases = @q.result.order(created_at: :desc)
      @purchases_for_view = @purchases.page(params[:page]).per(100)
    end
  
    def new
      @purchase = Purchase.new
    end
  
    def confirm
      @purchase = Purchase.new(purchase_params)
      add_breadcrumb "入力内容確認"
      if @purchase.valid?
        render :action =>  'confirm'
      else
        render :action => 'new'
      end
    end
  
    def thanks
      @purchase = Purchase.new(purchase_params)
      @purchase.save
      PurchaseMailer.received_email(@purchase).deliver # 管理者に通知
      PurchaseMailer.send_email(@purchase).deliver # 送信者に通知
    end
    
    def create
      params[:purchase][:option] = [] unless params[:purchase][:option].is_a?(Array)
      @purchase = Purchase.new(purchase_params)
      @purchase.save
      redirect_to thanks_purchases_path
    end
  
    def show
      @purchase = Purchase.find_by(id: params[:id])
    end
  
    def edit
      @purchase = Purchase.find(params[:id])
    end
  
    def destroy
      @purchase = Purchase.find(params[:id])
      @purchase.destroy
      redirect_to purchases_path, alert:"削除しました"
    end
  
    def update
      @purchase = Purchase.find(params[:id])
      if @purchase.update(purchase_params)
        redirect_to purchases_path(@purchase), alert: "更新しました"
      else
        render 'edit'
      end
    end
  
    private
    def purchase_params
      params.require(:purchase).permit(
        :co, #会社名
        :name, #名前
        :tel, #電話番号
        :address, #住所
        :email, #メールアドレス
        :vender, #自販機種類
        :installment, #分割
        :period, #設置希望時期
        :remarks, #要望
        {option: []}
      )
    end
  end
  