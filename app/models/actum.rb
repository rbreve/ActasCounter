class Actum < ActiveRecord::Base
  attr_accessible :alianza, :dc, :liberal, :libre, :nacional, :numero, :pac, :pinu, :ud, :nulos, :blancos, :user_id
  
  validates :numero, :uniqueness=>true
  belongs_to :user
  has_many :verifications
end
