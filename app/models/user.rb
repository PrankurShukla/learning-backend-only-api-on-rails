class User < ApplicationRecord
    has_secure_password  # requires password_digest column
    enum :role, { customer: "customer", admin: "admin" }, default: "customer"
    validates :email, presence: true, uniqueness: true
    has_many :orders, dependent: :destroy
end
