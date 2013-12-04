class Municipio < ActiveRecord::Base
  attr_accessible :name, :num, :departamento_id
  belongs_to :departamento
  has_many :actas
end
