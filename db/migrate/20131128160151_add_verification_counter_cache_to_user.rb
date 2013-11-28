class AddVerificationCounterCacheToUser < ActiveRecord::Migration
  def change
    add_column :users, :verifications_count, :integer, :default=>0
  end
end
