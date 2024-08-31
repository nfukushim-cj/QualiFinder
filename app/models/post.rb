class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  validates :user_id, presence: true
  validates :genre_id, presence: true
  validates :tool_name, presence: true
  validates :tool_description, presence: true
  validates :qualification_name, presence: true

  def get_image
    if image.attached?
      image
    else
      'no_image.jpg'
    end
  end
end
