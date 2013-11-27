class Actum < ActiveRecord::Base
  attr_accessible :alianza, :dc, :liberal, :libre, :nacional, :numero, :pac, :pinu, :ud, :nulos, :blancos, :user_id
  belongs_to :user
end
