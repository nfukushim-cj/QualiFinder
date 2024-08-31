class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @follow = Follow.find_by(user_id: current_user.id, following_user_id: @user.id)
    if @follow.nil?
      @follow = Follow.new
    end
    @posts = @user.posts.where(is_draft: false)
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "登録に成功しました。"
      redirect_to user_path(@user.id)
    else
       flash.now[:alert] = "登録に失敗しました。"
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "退会しました。"
      redirect_to admin_users_path
    else
       flash.now[:alert] = "退会に失敗しました。"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :user_name, :profile_image)
  end

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width,height]).processed
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to edit_user_path(current_user.id)
    end
  end

end
