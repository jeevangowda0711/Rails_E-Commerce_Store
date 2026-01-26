class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :first_name, :last_name, presence: true

  validates :password, length: { minimum: 12 }, format: {
    with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\w\s]).+\z/, message: "Must include at least on lower case letter, one upper case letter, one digit, and one symbol" },
    if: :password_required?

  def full_name
    "#{first_name} #{last_name}"
  end

  private
  def password_required?
    password_digest.blank? || password.present?
  end
end
