class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  before_action :set_item, except: [:index, :new, :create, :show, :purchase, :get_category_children, :get_category_grandchildren]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_category, only: [:new, :edit, :create, :update, :destroy]

  def index
    @items = Item.includes(:images).order("RAND()").limit(5)
    @user = current_user
  end

  def show
    @item = Item.find(params[:id])
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
    @user = current_user
  end

  def new
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      @item.images.new
      render :new
    end
  end

  def edit
    @brand = Brand.new
    @brand.items.new
    grandchild_category = @item.category
    child_category = @item.category.parent

    @category_parent_array = []
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent
    end

    @category_children_array = []
    Category.where(ancestry: child_category.ancestry).each do |children|
      @category_children_array << children
    end

    @category_grandchildren_array = []
    Category.where(ancestry: grandchild_category.ancestry).each do |grandchildren|
      @category_grandchildren_array << grandchildren
    end
  end

  def update
    if item_params[:images_attributes].nil?
      render :edit
    end
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def get_category_children
    @category_children = Category.find(params[:parent_id]).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:child_id]).children
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

  def set_category
    @category_parent_array = Category.where(ancestry: nil)
  end
end
