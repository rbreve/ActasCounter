class AddMunicipioIdToActum < ActiveRecord::Migration
  def change
    add_column :acta, :municipio_id, :integer
  end
end
