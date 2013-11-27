class Verification < ActiveRecord::Base
  attr_accessible :liberal,:nacional,:libre,:pac,:ud,:dc,:alianza,:pinu,:blancos,:nulos,:is_valid,:acta_id,:user_id
  belongs_to :user
  
  validates :user_id, :uniqueness => {:scope => :acta_id}
end
