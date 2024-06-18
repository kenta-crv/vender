class ReportsController < ApplicationController
    before_action :load_purchase
    before_action :load_report, only: [:edit,:update,:show,:destroy]
    #before_action :authenticate_user!

    def load_purchase
      @purchase = Purchase.find(params[:purchase_id])
      @report = Report.new
    end

    def load_report
      @report = Report.find(params[:id])
    end

    def edit
    end

    def create
      @report = @purchase.reports.new(report_params)
      if @report.save
  			redirect_to purchase_path(@purchase)
  		end
    end

  	def destroy
  		@purchase = Purchase.find(params[:purchase_id])
  		@report = @purchase.reports.find(params[:id])
  		@report.destroy
  		redirect_to purchase_path(@purchase)
  	end

  	 def update
      @report = Report.find(params[:purchase_id])
      @report = @purchase.reports.find(params[:id])
      if @report.update(report_params)
         redirect_to purchase_path(@purchase)
      else
          render 'edit'
      end
    end

    private
   	def report_params
   		params.require(:report).permit(
       :status,
       :next,
       :body,
      )
   	end

end
