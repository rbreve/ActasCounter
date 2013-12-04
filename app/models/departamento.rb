class Departamento < ActiveRecord::Base
  attr_accessible :name, :num, :from_actum, :to_actum
  has_many :municipios
end
