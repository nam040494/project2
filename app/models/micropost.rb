class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> {order created_at: :desc}
  mount_uploader :picture, PictureUploader

  validates :user, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.micropost.content.max_length}
  validate :picture_size

  scope :feed, -> (user_id){where user_id: user_id}

  private

  def picture_size
    if picture.size > Settings.micropost.picture_size.megabytes
      errors.add :picture, I18n.t("errors.messages.size_error")
    end
  end
end
