class ItemsController < ApplicationController
  def index
    @q = Item.ransack(params[:q])
    @items = @q.result
    @items = @items.page(params[:page]).per(20).order(created_at: :desc)
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path
    else
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id]) # 必要に応じて設定
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(Item_params)
        redirect_to item_path
    else
        render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @Item.destroy
    redirect_to item_path# または適切なパスに変更
  end

  private

 def item_params
  params.require(:item).permit(
      :name,
      :sales_price,
      :purchase_price,
      :image,
      :numbers,
      :manufacturer,
  )
  end
end
