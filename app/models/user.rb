class User < ApplicationRecord
    has_secure_password  # requires password_digest column
    validates :email, presence: true, uniqueness: true
end
