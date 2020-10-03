class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :create]
  before_action :set_item, except: [:index, :new, :create, :show]
  before_action :authenticate_user!, except: [:index, :show]

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
    @category_parent = Category.where(ancestry: nil)
  end

  def update
    if @item.update(product_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :detail, :category_id, :price, :condition_id, :delivery_fee_id, :prefecture_id, :delivery_day_id, images_attributes: [:image, :_destroy, :id], brand_attributes: [:name, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
    return if @item.seller_id == current_user.id

    redirect_to action: :index
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end
