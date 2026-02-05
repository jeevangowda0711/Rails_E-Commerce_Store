class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :wishlists, dependent: :destroy

  attr_readonly :admin

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :first_name, :last_name, presence: true

  validates :password, length: { minimum: 12 }, format: {
    with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\w\s]).+\z/, message: "Must include at least on lower case letter, one upper case letter, one digit, and one symbol" },
    if: :password_required?

  generates_token_for :email_confirmation, expires_in: 7.days do
    unconfirmed_email
  end

  def confirm_email
    update(email_address: unconfirmed_email, unconfirmed_email: nil)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private
  def password_required?
    password_digest.blank? || password.present?
  end
end
