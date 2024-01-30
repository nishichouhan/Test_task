class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:twitter, :facebook]
  has_many :posts       

  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0, 20]
  #   end
  # end

  # def self.from_omniauth(auth)
  #   byebug
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #   user.email = auth.info.email
  #   user.password = Devise.friendly_token[0, 20]
  #   # user.name = auth.info.name # assuming the user model has a name
  #   # user.username = auth.info.nickname # assuming the user model has a username
  #   #user.image = auth.info.image # assuming the user model has an image
  #   # If you are using confirmable and the provider(s) you use validate emails,
  #   # uncomment the line below to skip the confirmation emails.
  #   # user.skip_confirmation!
  #   end
  # end

  # def self.from_omniauth(auth)
  #     name_split = auth.info.name.split(" ")
  #     user = User.where(email: auth.info.email).first
  #     user ||= User.create!(provider: auth.provider, uid: auth.uid, email: auth.info.email || 'nishic.shriffle@gmail.com', password: Devise.friendly_token[0, 20])
  #       user
  # end

  def self.from_omniauth(auth)
    Rails.logger.debug("Omniauth data: #{auth.inspect}")

    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      Rails.logger.debug("User attributes: #{user.attributes}")
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
