class Micropost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  default_scope -> {order created_at: :desc}
  mount_uploader :picture, PictureUploader

  validates :user, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.micropost.content.max_length}
  validate :picture_size

  scope :feed, (lambda do |user_id|
    following_ids = "SELECT followed_id FROM relationships
      WHERE  follower_id = :user_id"
    where("user_id IN (#{following_ids})
      OR user_id = :user_id", user_id: user_id)
  end)

  private

  def picture_size
    if picture.size > Settings.micropost.picture_size.megabytes
      errors.add :picture, I18n.t("errors.messages.size_error")
    end
  end
end
