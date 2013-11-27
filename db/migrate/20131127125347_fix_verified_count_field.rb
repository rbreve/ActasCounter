class FixVerifiedCountField < ActiveRecord::Migration
  def up
    remove_column :acta, :verified
    add_column :acta, :verified_count, :integer, :default=>0
  end

  def down
    add_column :acta, :verified, :integer
    remove_column :acta, :verified_count
  end
end
