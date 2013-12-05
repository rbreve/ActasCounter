class AddImageToReports < ActiveRecord::Migration
  def change
    add_column :reportes, :imagenActa, :string
  end
end
