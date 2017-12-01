class MoreSums < ActiveRecord::Migration
  def change
    add_column :acta, :recibidas, :integer
    add_column :acta, :sobrantes, :integer
    add_column :acta, :ciudadanos, :integer
    add_column :acta, :miembros_mer, :integer
  end
end
