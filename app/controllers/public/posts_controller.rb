class Public::PostsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.where(is_draft: "false")
  end

  def show
    @post = Post.find_by(id: params[:id], is_draft: false)
  end

  def edit
    @post = Post.find(params[:id])

  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      if @post.is_draft
        flash[:notice] = "下書き登録に成功しました。"
        redirect_to draft_path
      else
        flash[:notice] = "投稿に成功しました。"
        redirect_to post_path(@post.id)
      end
    else
      flash.now[:alert] = "登録に失敗しました。"
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "修正が成功しました。"
      if @post.is_draft
        redirect_to draft_path
      else
        redirect_to post_path(@post.id)
      end
    else
      flash.now[:alert] = "修正に失敗しました。"
      render :edit
    end
  end

  def destroy
    image = Post.find(params[:id])
    if image.destroy
      flash[:notice] = "削除に成功しました。"
      redirect_to user_path(current_user.id)
    else
      flash.now[:alert] = "削除に失敗しました。"
      render :index
    end
  end

  private

  def post_params
    params.require(:post).permit(:image, :user_id, :genre_id, :tool_name, :tool_description, :qualification_name, :url, :is_draft)
  end

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end

    image

  end

  def is_matching_login_user
    post = Post.find(params[:id])
    unless post.user_id == current_user.id
      redirect_to posts_path
    end
  end

end
