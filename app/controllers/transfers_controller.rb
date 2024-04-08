class TransfersController < ApplicationController
  before_action :check_admin
  before_action :load_estimate
  before_action :load_transfer, only: [:edit,:update,:show,:destroy]
  #before_action :authenticate_user!

  def load_estimate
    @estimate = Estimate.find(params[:estimate_id])
    @transfer = Transfer.new
  end

  def load_transfer
    @transfer = Transfer.find(params[:id])
  end

  def edit
  end

  def create
    @transfer = @estimate.build_transfer(transfer_params)
    if @transfer.save
      redirect_to estimate_path(@estimate)
    else
      render 'new'
    end
  end
  
  def destroy
    @transfer = @estimate.transfer
    @transfer.destroy
    redirect_to estimate_path(@estimate)
  end
  
  def update
    @transfer = @estimate.transfer
    if @transfer.update(transfer_params)
      redirect_to estimates_path(@estimates)
    else
      render 'edit'
    end
  end

  private
 	def transfer_params
 	params.require(:transfer).permit(
    :bank,
    :branch,
    :number,
    :name,
    :body,
    :document
    )
 	end
end
