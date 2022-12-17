class User < ApplicationRecord

    # Encrypt password
    has_secure_password

    # Validates the attributes of the users

    validates :name, presence: true
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password,
               length: { minimum: 6 },
               if: -> { new_record? || !password.nil? }
               
end
