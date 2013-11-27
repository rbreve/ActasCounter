class AddNulosBlancosToActa < ActiveRecord::Migration
  def change
    add_column :acta, :blancos, :integer
    add_column :acta, :nulos, :integer
  end
end
