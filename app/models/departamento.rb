class Departamento < ActiveRecord::Base
  attr_accessible :name, :num, :actum_from, :actum_to
  has_many :municipios
end
