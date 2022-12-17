require "jwt"

module JwtToken

  extend ActiveSupport::Concern

  # Secret key for JSON Web Token encoding
  KEY = Rails.application.secrets.secret_key_base. to_s

  # Encodes the payload using HS256 algorithm and the Rails secret key
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode payload, KEY, 'HS256'
  end

  # Decodes the payload using HS256 algorithm and the Rails secret key
  def self.decode(token)
    puts token
    decoded = JWT.decode token, KEY, true, { algorithm: 'HS256' } 
    HashWithIndifferentAccess.new decoded[0]
  end

end