class AddNumeroIndex < ActiveRecord::Migration
  def up
    add_index(:acta, [:numero], :name=>'acta_numero_index')
  end
  
  def down
    remove_index(:acta, :name=>'acta_numero_index')
  end
end
