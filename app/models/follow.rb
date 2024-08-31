class Follow < ApplicationRecord
  belongs_to :user

  validates :following_user_id, uniqueness: {scope: :user_id}
end
