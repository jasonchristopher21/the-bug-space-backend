require "jwt"

module JwtToken

  extend ActiveSupport::Concern
  
  KEY = Rails.application.secrets.secret_key_base. to_s

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode payload, KEY, 'HS256'
  end

  def self.decode(token)
    puts token
    decoded = JWT.decode token, KEY, true, { algorithm: 'HS256' } 
    HashWithIndifferentAccess.new decoded[0]
  end

end

# module JwtToken

#     extend ActiveSupport::Concern

#     KEY = Rails.application.secrets.secret_key_base, to_s

#     def encode(payload, exp: 7.days_from_now)
#         payload[:exp] = exp.to_i
#         encode(payload, KEY)
#     end

#     def decode(token)
#         decoded = JWT.decode(token, KEY)[0]
#         HashWithIndifferentAccess.new decoded
#     end
    
# end