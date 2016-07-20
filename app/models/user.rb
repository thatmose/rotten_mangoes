class User < ApplicationRecord
  has_secure_password

  has_many :reviews, dependent: :destroy

  validates :email,
   presence: true, uniqueness: true

  validates :firstname,
   presence: true

  validates :lastname,
   presence: true

  validates :password,
   length: { in: 6..20 }, on: :create

  def full_name
    "#{firstname} #{lastname}"
  end

  def review_count
    self.reviews.count
  end
end
