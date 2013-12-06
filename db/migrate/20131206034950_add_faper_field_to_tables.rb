class AddFaperFieldToTables < ActiveRecord::Migration
  def change
    add_column :acta, :faper, :integer, :default=>0
    add_column :verifications, :faper, :integer, :default=>0
  end
end
