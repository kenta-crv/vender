class ClientsController < ApplicationController
  before_action :authenticate_client!, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, only: [:index]
  before_action :correct_client, only: [:show, :edit, :update, :destroy]

  def index
    # 管理者が全クライアント情報を確認できるアクション
    @clients = Client.all
  end

  def show
    # クライアントが自分自身の情報を確認できるアクション
    @client = Client.find(params[:id])
  end

  # その他のアクション...

  private

  def correct_client
    @client = Client.find(params[:id])
    redirect_to(root_path) unless current_client?(@client) || current_admin?
  end

  def current_client?(client)
    client == current_client
  end

  

  # current_admin? メソッドはAdminモデルに依存するため、
  # そのモデルの実装に合わせて定義する必要があります。
end