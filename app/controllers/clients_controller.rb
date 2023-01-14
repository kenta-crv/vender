class ClientsController < ApplicationController
  before_action :authenticate_client!

  def show
    @client = Client.find(params[:id])
  end
end
