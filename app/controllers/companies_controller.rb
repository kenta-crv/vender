class CompaniesController < ApplicationController
before_action :authenticate_admin!, only: :index

  def index
    @q = Company.ransack(params[:q])
    @companies = @q.result
    @companies = @companies.page(params[:page]).per(20).order(created_at: :desc)
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
        redirect_to companies_path
    else
        render 'edit'
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    if @company.update(company_params)
        redirect_to companies_path
    else
        render 'edit'
    end
  end

 def destroy
   @company = Company.find(params[:id])
   @company.destroy
   redirect_to companies_path
 end

private
 def company_params
  params.require(:company).permit(
    :company, #会社名
    :name, #代表者
    :tel,
    :address,
    :mail, #URL
    :remarks, #備考
    :image
  )
  end
end
