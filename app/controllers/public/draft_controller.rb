class Public::DraftController < ApplicationController
  def index
    @posts = Post.where(is_draft: true)
  end
end
