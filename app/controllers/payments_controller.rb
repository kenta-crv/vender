class PaymentsController < ApplicationController
    before_action :check_admin
    before_action :load_estimate, except: [:index]
    #before_action :authenticate_user!

    def load_estimate
      @estimate = Estimate.find(params[:estimate_id])
    end

    def index
       @q = Estimate.joins(:payments).joins(:transfer).where.not("transfers.id": nil).ransack(params[:q])
       @estimates_for_view = @q.result.page(params[:page]).per(100).order(created_at: :desc)
    end

    def edit
        @payment = @estimate.payments.find(params[:id])
    end

    def create
      @payment = @estimate.payments.new(payment_params)
      if @payment.save
  		redirect_to estimate_path(@estimate)
  	  end
    end

  	def destroy
  		@estimate = Estimate.find(params[:estimate_id])
  		@payment = @estimate.payments.find(params[:id])
  		@payment.destroy
  		redirect_to estimate_path(@estimate)
  	end

  	 def update
      @estimate = Estimate.find(params[:estimate_id])
      @payment = @estimate.payments.find(params[:id])
      if @payment.update(payment_params)
         redirect_to estimate_path(@estimate)
      else
          render 'edit'
      end
    end

    private
   	def payment_params
   		params.require(:payment).permit(
       :year,
       :month,
       :sales,
       :complete,
      )
   	end
end
