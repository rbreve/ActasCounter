class AddIndexesForCounts < ActiveRecord::Migration
  def up
    add_index(:acta, [:liberal,:nacional,:libre,:pac,:ud,:dc,:alianza,:pinu,:blancos,:nulos], :name=>'acta_counts_index')
  end
  
  def down
    remove_index(:acta, :name=>'acta_counts_index')
  end
end
