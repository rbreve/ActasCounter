class Municipio < ActiveRecord::Base
  attr_accessible :name, :num, :departamento_id, :from_actum, :to_actum
  belongs_to :departamento
  has_many :actas
end
