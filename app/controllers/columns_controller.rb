class ColumnsController < ApplicationController
  before_action :authenticate_admin!, except: [:index, :show]
  add_breadcrumb "トップページ", :root_path
  add_breadcrumb "記事一覧", :columns_path
  def index
    @columns = Column.order(created_at: "DESC").page(params[:page])
  end

  def show
    @column = Column.find(params[:id])
    add_breadcrumb @column.title, column_path(@column)
  end

  def new
    @column = Column.new
    render :layout => "froala"
  end

  def create
    @column = Column.new(column_params)
    if @column.save
      redirect_to columns_path
    else
      render 'new'
    end
  end

  def edit
    @column = Column.find(params[:id])
    render :layout => "froala"
  end

  def destroy
    @column = Column.find(params[:id])
    @column.destroy
     redirect_to columns_path
  end

  def update
    @column = Column.find(params[:id])
    if @column.update(column_params)
      redirect_to columns_path
    else
      render 'edit'
    end
  end

  private
  def column_params
    params.require(:column).permit(
      :title, #タイトル
      :kategory, #カテゴリー
      :description, #説明
      :heading_1, #見出し
      :file_1, #ファイル
      :content_1, #本文
      :heading_2, #見出し
      :file_2, #ファイル
      :content_2, #本文
      :heading_3, #見出し
      :file_3, #ファイル
      :content_3, #本文
      :heading_4, #見出し
      :file_4, #ファイル
      :content_4, #本文
      :heading_5, #見出し
      :file_5, #ファイル
      :content_5, #本文
      :heading_6, #見出し
      :file_6, #ファイル
      :content_6, #本文
      :heading_7, #見出し
      :file_7, #ファイル
      :content_7, #本文
      :heading_8, #見出し
      :file_8, #ファイル
      :content_8, #本文
      :heading_9, #見出し
      :file_9, #ファイル
      :content_9, #本文
      :heading_10, #見出し
      :file_10, #ファイル
      :content_10, #本文
      :heading_11, #見出し
      :file_11, #ファイル
      :content_11, #本文
      :heading_12, #見出し
      :file_12, #ファイル
      :content_12, #本文
      :heading_13, #見出し
      :file_13, #ファイル
      :content_13, #本文
      :heading_14, #見出し
      :file_14, #ファイル
      :content_14, #本文
      :heading_15, #見出し
      :file_15, #ファイル
      :content_15, #本文
      :heading_16, #見出し
      :file_16, #ファイル
      :content_16, #本文
      :heading_17, #見出し
      :file_17, #ファイル
      :content_17, #本文
      :heading_18, #見出し
      :file_18, #ファイル
      :content_18, #本文
      :heading_19, #見出し
      :file_19, #ファイル
      :content_19, #本文
      :heading_20, #見出し
      :file_20, #ファイル
      :content_20 #本文
      )
  end
end
