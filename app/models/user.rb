class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:twitter, :facebook]
  has_many :posts       

  def self.from_omniauth(auth)
    Rails.logger.debug("Omniauth data: #{auth.inspect}")

    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      Rails.logger.debug("User attributes: #{user.attributes}")
      user.email = auth.info.email
      user.access_token =  auth.credentials.token
      user.consumer_secret_key =  auth.extra.access_token.consumer.secret
      user.consumer_key =  auth.extra.access_token.consumer.key
      user.access_secret_token =  auth.credentials.secret
      user.password = Devise.friendly_token[0, 20]
    end
  end
end


