class Movie < ApplicationRecord
  has_many :reviews

  mount_uploader :image, ImageUploader
  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :image,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  scope :title_name_like, ->(title_q) { where("title LIKE ?", "%#{title_q}%")}
  scope :director_name_like, ->(director_q) { where("director LIKE ?", "%#{director_q}%")}
  scope :duration_less_than_90, -> { where("runtime_in_minutes < 90 ") }
  scope :duration_greater_than_120, -> { where("runtime_in_minutes > 120 ") }
  scope :duration_btn_90_120, -> { where(runtime_in_minutes: (90..120)) }

  def review_average
    if reviews.size.zero?
      result = "- "
    else
      result = reviews.sum(:rating_out_of_ten)/reviews.size
    end
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end
end
