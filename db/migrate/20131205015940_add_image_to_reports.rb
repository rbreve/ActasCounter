class AddImageToReports < ActiveRecord::Migration
  def change
    add_column :reportes, :image, :string
  end
end
