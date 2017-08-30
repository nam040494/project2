class Micropost < ActiveRecord::Base
  belongs_to :user
  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.microposts.content.maximum}
  validate  :picture_size

  default_scope -> {order(created_at: :desc)}
  scope :feed, (lambda do |user_id|
    following_ids = "SELECT followed_id FROM relationships
      WHERE  follower_id = :user_id"
    where("user_id IN (#{following_ids})
      OR user_id = :user_id", user_id: user_id)
  end)

  private

  def picture_size
    if picture.size > Settings.picture_size.size.megabytes
      errors.add :picture, I18n.t(".error")
    end
  end
end
