class ProgressesController < ApplicationController
    before_action :check_admin
    before_action :load_estimate
    before_action :load_progress, only: [:edit,:update,:show,:destroy]
    #before_action :authenticate_user!

    def load_estimate
      @estimate = Estimate.find(params[:estimate_id])
      @progress = Progress.new
    end

    def load_progress
      @progress = Progress.find(params[:id])
    end

    def edit
    end

    def create
      @progress = @estimate.progresses.new(progress_params)
      if @progress.save
  			redirect_to estimate_path(@estimate)
  		end
    end

  	def destroy
  		@estimate = Estimate.find(params[:estimate_id])
  		@progress = @estimate.progresses.find(params[:id])
  		@progress.destroy
  		redirect_to estimate_path(@estimate)
  	end

  	 def update
      @progress = Progress.find(params[:estimate_id])
      @progress = @estimate.progresses.find(params[:id])
      if @progress.update(progress_params)
         redirect_to estimate_path(@estimate)
      else
          render 'edit'
      end
    end

    private
   	def progress_params
   		params.require(:progress).permit(
       :status,
       :document,
       :next,
       :body,
      )&.merge(admin: current_admin)
   	end

end
