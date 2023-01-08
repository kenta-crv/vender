class TopController < ApplicationController
  def index
  end

  def faq
  end

  def corporation
  end

  def question
  end

  def cocacola
    render :layout => "cocacola"
    @vender = "コカコーラ"
  end

  def asahi
    render :layout => "asahi"
    @vender = "アサヒ"
  end

  def otsuka
    render :layout => "otsuka"
    @vender = "大塚"
  end

  def itoen
    render :layout => "itoen"
    @vender = "伊藤園"
  end

  def dydo
    render :layout => "dydo"
    @vender = "ダイドー"
  end

  def kirin
    render :layout => "kirin"
    @vender = "キリン"
  end

  def suntory
    render :layout => "suntory"
    @vender = "サントリー"
  end

end
