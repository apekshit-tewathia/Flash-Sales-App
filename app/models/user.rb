class User < ApplicationRecord
  has_secure_password
  has_secure_token :verification_token
  has_many :deals, foreign_key: 'created_by'
  has_many :orders, dependent: :destroy
  has_many :order_transaction, through: :orders
  has_many :addresses, dependent: :destroy
  has_many :line_items, through: :orders

  validates :name, :email, presence: true
  validates :password, confirmation: true, allow_blank: true
  validates :password, :password_confirmation, presence: true, if: :setting_password?
  validates :email, format: { with: FlashSales::User::EMAIL_REGEX }, uniqueness: true

  after_create_commit :send_verification_email, unless: :verified_at?

  enum role: { user: 'user', admin: 'admin' }

  private
    def send_verification_email
      UserMailer.verify_email(self).deliver_now if user?
    end

    def setting_password?
      password || password_confirmation
    end
end
