class Reporte < ActiveRecord::Base
  attr_accessible :acta_id, :body, :date, :user_id, :imagenActa
  belongs_to :actum, class_name: "Actum",:foreign_key=>"acta_id"
  belongs_to :user
  mount_uploader :imagenActa, ImagenReporteUploader
  
end
