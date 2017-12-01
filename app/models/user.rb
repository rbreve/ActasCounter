class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :lastname, :name, :password, :password_confirmation, :remember_me,:provider, :uid, :is_admin, :verifications_count, :acta_count
  
  has_many :acta
  has_many :verifications
  
  def shortname
    if lastname
      "#{name} #{lastname[0]}"
    else
      name
    end
  end
  
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first

    unless user
      user = User.create(name:(auth.info.name || auth.extra.raw_info.first_name || auth.extra.raw_info.name), lastname:(auth.extra.raw_info.last_name || ""),
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email || "#{auth.uid}@#{auth.uid}.net",
                           password:Devise.friendly_token[0,20]
                           )
    end
    user
  end
  
 
  def calculated_verification_count
    v_count = self.verifications_count || 0
    a_count = self.acta_count || 0
    if v_count-a_count<0
      0
    else
      v_count-a_count
    end
  end
  
  
end
