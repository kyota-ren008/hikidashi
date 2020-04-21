class Post < ApplicationRecord
  has_one_attached :image
  validates :name, presence: true#, length: { maximum: 30 }

  belongs_to :user

  scope :recent, -> { order(created_at: :desc) }

end
