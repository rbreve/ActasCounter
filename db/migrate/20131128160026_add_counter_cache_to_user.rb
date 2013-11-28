class AddCounterCacheToUser < ActiveRecord::Migration
  def change
    add_column :users, :acta_count, :integer
  end
end
