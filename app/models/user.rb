class User < ActiveRecord::Base

  validates_uniqueness_of :code, :authentication_token
  validates_presence_of :code

  def to_param
    code
  end

  def generate_token
    self.authentication_token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(authentication_token: random_token)
    end
  end

end
