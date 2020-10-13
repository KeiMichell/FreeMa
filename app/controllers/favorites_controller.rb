class FavoritesController < ApplicationController

  def create
    user = current_user
    item = Item.find(params[:item_id])
    Favorite.create(user_id: user.id, item_id: item.id)
    redirect_back(fallback_location: root_path) 
  end

  def destroy
    user = current_user
    item = Item.find(params[:item_id])
    favorite = Favorite.find_by(user_id: user.id, item_id: item.id)
    favorite.delete
    redirect_back(fallback_location: root_path) 
  end
end
