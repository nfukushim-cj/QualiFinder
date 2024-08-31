class Public::FollowsController < ApplicationController

  def index
    @follows = Follow.where(user_id: current_user.id)
  end

  def create
    user = User.find(params[:user_id])
    @follow = current_user.follows.new(following_user_id: user.id)
    if @follow.save
      flash[:notice] = "フォローしました。"
    else
       flash.now[:alert] = "フォローに失敗しました。"
    end
    redirect_to user_path(user.id)
  end

  def destroy
    user = User.find(params[:user_id])
    follow = Follow.find_by(user_id: current_user.id, following_user_id: user.id )
    if follow.destroy
      flash[:notice] = "フォローを解除しました。"
    else
       flash.now[:alert] = "フォロー解除に失敗しました。"
    end
    redirect_to user_path(user.id)
  end

  private

  def follow_params
    params.require(:follow).permit(:user_id, :following_user_id)
  end

end
