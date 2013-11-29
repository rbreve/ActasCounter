class Reporte < ActiveRecord::Base
  attr_accessible :acta_id, :body, :date, :user_id
  belongs_to :acta
end
