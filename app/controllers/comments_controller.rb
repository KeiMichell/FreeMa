class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    respond_to do |format|
      format.html { redirect_to item_path(params[:item_id]) }
      format.json
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      redirect_to item_path(comment.item.id), notice: "削除が完了しました"
    else
      redirect_to item_path(comment.item.id), alert: "削除が失敗しました"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
