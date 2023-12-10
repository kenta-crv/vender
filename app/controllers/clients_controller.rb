class ClientsController < ApplicationController
  before_action :check_client
  def index
    @clients = Client.all
  end

  def show
    @client = Client.find(params[:id])
    @estimates = current_client.estimates
  end

  def disclose
    @client = Client.find(params[:id])
    @client.update(disclosure_clicked_at: Time.current)
    # 開示された案件情報を表示するためのロジック
    redirect_to client_path(@client)
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to @client, notice: 'クライアントが正常に作成されました。'
    else
      render :new
    end
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    if @client.update(client_params)
      redirect_to @client, notice: 'クライアント情報が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    redirect_to clients_url, notice: 'クライアントが削除されました。'
  end

  private

  def client_params
    params.require(:client).permit(:company, :name, :tel, :email, :password, :password_confirmation)
  end
end