class Verification < ActiveRecord::Base
  attr_accessible :liberal,:nacional,:libre,:pac,:ud,:dc,:alianza,:pinu,:blancos,:nulos,:is_valid,:acta_id,:user_id
  belongs_to :user
  
  validates :user_id, :uniqueness => {:scope => :acta_id}
  
  validates :alianza, :dc, :liberal, :libre, :nacional, :pac, :pinu, :ud, :nulos, :blancos, :numericality => { :greater_than_or_equal_to=>0, :less_than_or_equal_to => 400 }, :presence => true
    
end
