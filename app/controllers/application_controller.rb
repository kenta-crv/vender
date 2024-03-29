class ApplicationController < ActionController::Base
  include SessionHelper
  before_action :set_host
  before_action :set_footer

  def check_admin
    unless admin_signed_in?
      flash[:alert] = "管理者専用のページです。"
      redirect_to root_path
    end
  end
  
  def check_client
    unless client_signed_in?
      flash[:alert] = "クライアント専用のページです。"
      redirect_to root_path
    end
  end

  # 例外処理

   rescue_from ActiveRecord::RecordNotFound, with: :render_404 unless Rails.env.development?
   rescue_from ActionController::RoutingError, with: :render_404 unless Rails.env.development?
   rescue_from Exception, with: :render_500 unless Rails.env.development?

   def set_host
      Rails.application.routes.default_url_options[:host] = request.host_with_port
   end

   def render_404
    render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
   end

   def render_500
    render template: 'errors/error_500', status: 500, layout: 'application', content_type: 'text/html'
   end

   def set_footer
     @columns = Column.all
   end

private
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      "/estimates"
    when Client
      client_path(resource)
    else
      "/"
    end
  end

  def after_sign_out_path_for(resource)
    case resource
    when Admin, :admin, :admins
      "/"
    when Client, :client, :clients
      "/"
    else
       super
    end
  end
end
