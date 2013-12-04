class Departamento < ActiveRecord::Base
  attr_accessible :name, :num
  has_many :municipios
end
