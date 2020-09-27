class ItemsController < ApplicationController
  def index
    @items = Item.includes(:images).order('created_at DESC')
  end

  def show
  end

  def new
    @item = Item.new
    @item.images.new
    @category_parent = Category.where(ancestry: nil)
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :detail, :category_id, :brand_id, :price, :condition_id, :delivery_fee_id, :prefecture_id, :delivery_day_id, images_attributes: [:image]).merge(seller_id: current_user.id)
  end

end
