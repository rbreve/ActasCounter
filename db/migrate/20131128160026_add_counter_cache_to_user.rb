class AddCounterCacheToUser < ActiveRecord::Migration
  def change
    add_column :users, :acta_count, :integer, :default=>0
  end
end
