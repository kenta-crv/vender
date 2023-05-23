class ClientsController < ApplicationController
  before_action :authenticate_client!

  def show
    @client = current_client
  end
end
