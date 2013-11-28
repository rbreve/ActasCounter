class AddIsSumOkBoolean < ActiveRecord::Migration
  def change
    add_column :acta, :is_sum_ok, :boolean, :default=>true
    add_column :verifications, :is_sum_ok, :boolean, :default=>true
  end
end
