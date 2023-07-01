class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
  end
  def show
    @cart_item=CartItem.new
    @items=Item.all
    @item=Item.find(params[:id])
  end
private
  def item_params
    params.require(:item).permit(:image,:name, :introduction, :price, :is_active)
  end
end
