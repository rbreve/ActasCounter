class Reporte < ActiveRecord::Base
  attr_accessible :acta_id, :body, :date, :user_id, :image
  belongs_to :actum, class_name: "Actum",:foreign_key=>"acta_id"
  belongs_to :user
  mount_uploader :image, ImagenReporteUploader 
end
