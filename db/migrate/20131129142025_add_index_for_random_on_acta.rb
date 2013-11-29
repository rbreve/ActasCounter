class AddIndexForRandomOnActa < ActiveRecord::Migration
  def up
    add_index(:acta, [:user_id,:ready_for_review,:id,:verified_count], :name=>'acta_for_random_index')
  end
  
  def down
    remove_index(:acta, :name=>'acta_for_random_index')
  end
end