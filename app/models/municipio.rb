class Municipio < ActiveRecord::Base
  attr_accessible :name, :num, :departamento_id, :actum_from, :actum_to
  belongs_to :departamento
  has_many :actas
end
