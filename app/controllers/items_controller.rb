class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  before_action :set_item, except: [:index, :new, :create, :show, :purchase]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @items = Item.includes(:images).order('created_at DESC')
  end

  def show
    @item = Item.find(params[:id])
    @category_grandchild = Category.find(@item.category_id)
    @category_child = @category_grandchild.parent
    # @category_parent = @category_child.parent
  end

  def new
    @item = Item.new
    @item.images.new
    @category_parent = Category.where(ancestry: nil)
  end

  def create
    @category_parent = Category.where(ancestry: nil)
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      @item.images.new
      render :new
    end
  end

  def edit
    @category_parent = Category.where(ancestry: nil)
  end

  def update
    @category_parent = Category.where(ancestry: nil)
    if item_params[:images_attributes].nil?
      render :edit
    end
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def purchase
    @item = Item.find(params[:id])
    @user = current_user
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
