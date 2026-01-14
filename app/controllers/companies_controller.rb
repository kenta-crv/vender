class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  def index
    @q = Company.ransack(params[:q])
    @companies = @q.result
    @companies = @companies.page(params[:page]).per(20).order(created_at: :desc)
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @client = current_client
    @company = @client.build_company
  end

  def create
    @company = current_client.build_company(company_params)
    if @company.save
      redirect_to client_path(current_client)
    else
      render :new
    end
  end

  def edit
    @client = current_client # 必要に応じて設定
  end

  def update
    @company = Company.find(params[:id])
    if @company.update(company_params)
        redirect_to "/clients/#{current_client.id}"
    else
        render :edit
    end
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    redirect_to client_path(current_client) # または適切なパスに変更
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

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
