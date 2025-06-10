class TopController < ApplicationController
  def index
  end

  def lp
  end

  def original 
  end

  def business
  end

  def documents
    if params[:from].present?
      AccessLog.create!(
        source: params[:from],             # 例: estimate.id（文字列）
        path: request.path,                # 例: "/documents"
        ip: request.remote_ip,             # アクセス元のIP
        accessed_at: Time.current          # アクセス日時
      )
    end

    pdf_path = Rails.root.join('public', 'secondhands.pdf')
    if File.exist?(pdf_path)
      send_file pdf_path, filename: 'secondhands.pdf', type: 'application/pdf', disposition: 'attachment'
    else
      render plain: 'ファイルが見つかりません', status: 404
    end
  end

  def price
  end

  def flow
  end
  
  def corporation
  end

  def privacy
  end

  def question
  end

  def cocacola
  end

  def asahi
  end

  def otsuka

  end

  def itoen

  end

  def dydo

  end

  def kirin

  end

  def suntory
  end

  def inside 
  end

  def outside
  end

  def secondhand
  end

  def food 
  end
end
